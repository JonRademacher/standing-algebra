from __future__ import annotations
from dataclasses import dataclass, field, asdict
from enum import Enum
from pathlib import Path
from typing import Any
import json, time, uuid

class SolveStatus(str, Enum):
    PROVED = "PROVED"
    DISPROVED = "DISPROVED"
    COUNTEREXAMPLE_FOUND = "COUNTEREXAMPLE_FOUND"
    FORMALIZATION_UNRESOLVED = "FORMALIZATION_UNRESOLVED"
    PREMISE_MISSING = "PREMISE_MISSING"
    REPRESENTATION_MISMATCH = "REPRESENTATION_MISMATCH"
    VERIFIER_UNAVAILABLE = "VERIFIER_UNAVAILABLE"
    VERIFIER_TIMEOUT = "VERIFIER_TIMEOUT"
    SEARCH_BUDGET_EXHAUSTED = "SEARCH_BUDGET_EXHAUSTED"
    PARTIAL_LEMMAS_VERIFIED = "PARTIAL_LEMMAS_VERIFIED"
    UNRESOLVED = "UNRESOLVED"

@dataclass(frozen=True)
class Budget:
    max_rounds: int = 3
    branches_per_round: int = 4
    verifier_timeout_seconds: int = 60
    max_candidates: int = 24

@dataclass(frozen=True)
class EvidencePolicy:
    require_clean_replay: bool = True
    forbid_tokens: tuple[str, ...] = (
        "sorry", "admit", "axiom", "unsafe", "set_option pp.universes false in"
    )

@dataclass(frozen=True)
class ProblemContract:
    id: str
    theorem_name: str
    declaration: str
    imports: tuple[str, ...] = ()
    context: str = ""
    repository_root: str | None = None
    budget: Budget = field(default_factory=Budget)
    evidence: EvidencePolicy = field(default_factory=EvidencePolicy)
    metadata: dict[str, Any] = field(default_factory=dict)

    @classmethod
    def from_dict(cls, data: dict[str, Any]) -> "ProblemContract":
        data = dict(data)
        data["imports"] = tuple(data.get("imports", ()))
        data["budget"] = Budget(**data.get("budget", {}))
        evidence = data.get("evidence", {})
        if "forbid_tokens" in evidence:
            evidence["forbid_tokens"] = tuple(evidence["forbid_tokens"])
        data["evidence"] = EvidencePolicy(**evidence)
        return cls(**data)

    @classmethod
    def from_json(cls, path: str | Path) -> "ProblemContract":
        return cls.from_dict(json.loads(Path(path).read_text(encoding="utf-8")))

    def to_dict(self) -> dict[str, Any]:
        return asdict(self)

@dataclass
class Candidate:
    proof: str
    strategy: str
    parent_ids: list[str] = field(default_factory=list)
    round_index: int = 0
    id: str = field(default_factory=lambda: uuid.uuid4().hex[:12])
    created_at: float = field(default_factory=time.time)
    score_hint: float = 0.0

@dataclass
class VerificationResult:
    accepted: bool
    status: SolveStatus
    command: list[str]
    return_code: int | None
    stdout: str
    stderr: str
    duration_seconds: float
    workspace: str
    source_file: str
    diagnostics: list[dict[str, str]] = field(default_factory=list)
    rejected_tokens: list[str] = field(default_factory=list)

@dataclass
class CandidateRecord:
    candidate: Candidate
    verification: VerificationResult
    classification: str
    elimination_witness: str | None = None
    reopen_when: list[str] = field(default_factory=list)

@dataclass
class SolveResult:
    run_id: str
    problem_id: str
    status: SolveStatus
    proof: str | None
    accepted_candidate_id: str | None
    records: list[CandidateRecord]
    result_dir: str
    summary: dict[str, Any] = field(default_factory=dict)
