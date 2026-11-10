from __future__ import annotations
from dataclasses import dataclass, field, asdict
from enum import Enum
from pathlib import Path
from typing import Any
import hashlib, json, time

class EpistemicType(str, Enum):
    OBSERVATION="observation"
    SOURCE_CLAIM="source_claim"
    INFERENCE="inference"
    RECONSTRUCTION="reconstruction"
    HYPOTHESIS="hypothesis"
    ANALOGY="analogy"
    PREDICTION="prediction"
    FORMAL_CLAIM="formal_claim"
    VALIDATION="validation"
    CANONICAL_STATE="canonical_state"

class ExecutionState(str, Enum):
    UNDERSTOOD="UNDERSTOOD"
    PLANNED="PLANNED"
    ATTEMPTED="ATTEMPTED"
    EXECUTED="EXECUTED"
    VERIFIED="TERMINAL_STATE_VERIFIED"

@dataclass
class Provenance:
    source_id:str
    contributor:str|None=None
    epistemic_type:EpistemicType=EpistemicType.HYPOTHESIS
    authority_scope:str="candidate only"
    currentness:str="unknown"
    evidence:list[str]=field(default_factory=list)

@dataclass
class MethodClaim:
    id:str
    statement:str
    provenance:Provenance
    dependencies:list[str]=field(default_factory=list)
    status:str="CANDIDATE"
    residuals:list[str]=field(default_factory=list)
    reopening_conditions:list[str]=field(default_factory=list)
    representation:str|None=None
    equivalence_obligations:list[str]=field(default_factory=list)

@dataclass
class GEGAProfile:
    existence:list[str]=field(default_factory=list)
    identity:list[str]=field(default_factory=list)
    relations:list[str]=field(default_factory=list)
    environment:list[str]=field(default_factory=list)
    boundaries:list[str]=field(default_factory=list)
    realizations:list[str]=field(default_factory=list)
    consequences:list[str]=field(default_factory=list)
    updated_geometry:list[str]=field(default_factory=list)
    missing_structures:list[str]=field(default_factory=list)

@dataclass
class MethodologyContract:
    objective:str
    target_id:str
    claims:list[MethodClaim]
    gega:GEGAProfile=field(default_factory=GEGAProfile)
    endpoint_geometry:list[str]=field(default_factory=list)
    admissibility_constraints:list[str]=field(default_factory=list)
    completion_criteria:list[str]=field(default_factory=list)
    verification_contract:list[str]=field(default_factory=list)
    return_state_requirements:list[str]=field(default_factory=list)
    authority_scope:str="analysis and local artifacts only"

@dataclass
class ReviewResult:
    target_id:str
    execution_state:ExecutionState
    survivors:list[str]
    eliminated:dict[str,str]
    blocked:dict[str,list[str]]
    residuals:list[str]
    reopening_conditions:list[str]
    missing_structures:list[str]
    methodological_findings:list[str]
    certificate:dict[str,Any]

class MethodologyKernel:
    """Executable GEGA/MSI-UCK/OCEL review without creating mathematical truth."""
    failure_statuses={"REFUTED","INVALID","UNSAFE","OUT_OF_SCOPE","SUPERSEDED_FOR_TARGET"}
    proof_statuses={"VERIFIED","PROVED"}

    def review(self, contract:MethodologyContract) -> ReviewResult:
        by_id={c.id:c for c in contract.claims}
        eliminated={c.id:c.status for c in contract.claims if c.status in self.failure_statuses}
        survivors=[c.id for c in contract.claims if c.id not in eliminated]
        blocked={}
        for c in contract.claims:
            missing=[d for d in c.dependencies if d not in by_id or d in eliminated or by_id[d].status not in self.proof_statuses]
            if missing and c.id not in eliminated: blocked[c.id]=missing
        residuals=[]; reopen=[]
        for c in contract.claims:
            residuals.extend(f"{c.id}: {x}" for x in c.residuals)
            reopen.extend(f"{c.id}: {x}" for x in c.reopening_conditions)
            if c.representation and c.equivalence_obligations:
                residuals.extend(f"{c.id} equivalence: {x}" for x in c.equivalence_obligations)
        findings=[]
        if contract.gega.missing_structures:
            findings.append("GEGA localized missing structures instead of treating the objective as globally failed.")
        if len(survivors)>1:
            findings.append("Plural survivor landscape preserved; no hidden winner selected.")
        if blocked:
            findings.append("Dependency obstructions localized; blocked descendants were not promoted.")
        if any(c.provenance.epistemic_type==EpistemicType.HYPOTHESIS for c in contract.claims):
            findings.append("Hypotheses retained as hypotheses; compression did not promote epistemic type.")
        target=by_id.get(contract.target_id)
        target_verified=bool(target and target.status in self.proof_statuses and contract.target_id not in blocked)
        completion=all(contract.completion_criteria) and all(contract.verification_contract) and target_verified
        state=ExecutionState.VERIFIED if completion else ExecutionState.EXECUTED
        cert={
          "objective":contract.objective,
          "target_verified":target_verified,
          "completion_criteria_declared":contract.completion_criteria,
          "verification_contract":contract.verification_contract,
          "authority_scope":contract.authority_scope,
          "generated_at":time.time(),
          "claim_digest":hashlib.sha256(json.dumps([asdict(c) for c in contract.claims],sort_keys=True,default=str).encode()).hexdigest()
        }
        return ReviewResult(contract.target_id,state,survivors,eliminated,blocked,residuals,reopen,contract.gega.missing_structures,findings,cert)

def load_contract(path:str|Path)->MethodologyContract:
    raw=json.loads(Path(path).read_text())
    claims=[]
    for c in raw.get("claims",[]):
        p=c.get("provenance",{})
        p["epistemic_type"]=EpistemicType(p.get("epistemic_type","hypothesis"))
        c["provenance"]=Provenance(**p); claims.append(MethodClaim(**c))
    raw["claims"]=claims; raw["gega"]=GEGAProfile(**raw.get("gega",{}))
    return MethodologyContract(**raw)

def write_result(result:ReviewResult,path:str|Path):
    Path(path).write_text(json.dumps(asdict(result),indent=2,default=lambda x:x.value if isinstance(x,Enum) else str(x)),encoding="utf-8")
