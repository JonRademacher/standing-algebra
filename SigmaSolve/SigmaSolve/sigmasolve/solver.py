from __future__ import annotations
from dataclasses import asdict
from pathlib import Path
import json, time, uuid
from .models import ProblemContract, Candidate, CandidateRecord, SolveResult, SolveStatus
from .agents import AgentAdapter
from .verifiers import LeanVerifier
from .classify import classify
from .ledger import CandidateLedger
from .receipts import environment, write_manifest

class SigmaSolver:
    def __init__(self, agent: AgentAdapter, verifier: LeanVerifier | None = None, output_root: str | Path = "sigmasolve-results", verify: bool = True):
        self.agent=agent; self.verifier=verifier or LeanVerifier(); self.output_root=Path(output_root); self.verify_enabled=verify

    def solve(self, problem: ProblemContract) -> SolveResult:
        run_id=f"{problem.id}-{uuid.uuid4().hex[:8]}"
        run_dir=self.output_root/run_id; run_dir.mkdir(parents=True, exist_ok=False)
        (run_dir/"problem.json").write_text(json.dumps(problem.to_dict(), indent=2, sort_keys=True), encoding="utf-8")
        (run_dir/"environment.json").write_text(json.dumps(environment(), indent=2), encoding="utf-8")
        ledger=CandidateLedger(run_dir/"candidate-ledger.jsonl")
        records=[]; pending=self.agent.propose(problem, problem.budget.branches_per_round); seen=set(); accepted=None
        round_index=0
        while pending and len(records)<problem.budget.max_candidates and round_index<problem.budget.max_rounds:
            next_pending=[]
            for candidate in pending:
                fingerprint=candidate.proof.strip()
                if fingerprint in seen: continue
                seen.add(fingerprint); candidate.round_index=round_index
                if self.verify_enabled:
                    verification=self.verifier.verify(problem, candidate)
                else:
                    from .models import VerificationResult
                    verification=VerificationResult(True, SolveStatus.PROVED, [], 0, "verification disabled", "", 0.0, "", "")
                label, witness, reopen=classify(verification)
                record=CandidateRecord(candidate, verification, label, witness, reopen)
                records.append(record); ledger.append(record)
                if verification.accepted:
                    if self.verify_enabled and problem.evidence.require_clean_replay:
                        replay=self.verifier.verify(problem, candidate, clean=True)
                        (run_dir/"clean-replay.json").write_text(json.dumps(asdict(replay), indent=2), encoding="utf-8")
                        if replay.accepted: accepted=candidate; break
                    else: accepted=candidate; break
                if label not in {"verifier_unavailable", "unsafe_escape"} and round_index+1<problem.budget.max_rounds:
                    remaining=max(1, problem.budget.branches_per_round//max(1,len(pending)))
                    next_pending.extend(self.agent.repair(problem, record, remaining))
                if len(records)>=problem.budget.max_candidates: break
            if accepted: break
            pending=next_pending; round_index+=1
        if accepted:
            status=SolveStatus.PROVED
            (run_dir/"proof.lean.txt").write_text(accepted.proof, encoding="utf-8")
        elif any(r.verification.status==SolveStatus.VERIFIER_UNAVAILABLE for r in records): status=SolveStatus.VERIFIER_UNAVAILABLE
        elif len(records)>=problem.budget.max_candidates or round_index>=problem.budget.max_rounds: status=SolveStatus.SEARCH_BUDGET_EXHAUSTED
        else: status=SolveStatus.UNRESOLVED
        summary={"candidates_evaluated":len(records), "rounds":round_index+1, "verified":sum(r.verification.accepted for r in records), "unique_proofs":len(seen), "verify_enabled":self.verify_enabled}
        result=SolveResult(run_id, problem.id, status, accepted.proof if accepted else None, accepted.id if accepted else None, records, str(run_dir), summary)
        serial=asdict(result); serial["status"]=result.status.value
        (run_dir/"result.json").write_text(json.dumps(serial, indent=2), encoding="utf-8")
        write_manifest(run_dir)
        return result
