from __future__ import annotations
from dataclasses import dataclass,field,asdict
from pathlib import Path
import json, hashlib, time

@dataclass
class ContextTransfer:
    objective:str
    authoritative_state:list[str]
    applicable_rules:list[str]
    scope_boundaries:list[str]
    known_failure_shapes:list[str]
    evidence_requirements:list[str]
    mutation_conditions:list[str]
    completion_criteria:list[str]
    verification_contract:list[str]
    return_state:list[str]

    def sufficiency_gaps(self):
        gaps=[]
        for field_name,value in asdict(self).items():
            if not value: gaps.append(field_name)
        return gaps

@dataclass
class StateDelta:
    before:str
    attempted:list[str]=field(default_factory=list)
    executed:list[str]=field(default_factory=list)
    verified:list[str]=field(default_factory=list)
    unresolved:list[str]=field(default_factory=list)
    artifacts:list[str]=field(default_factory=list)

class OCELRunner:
    def gate(self,transfer:ContextTransfer):
        gaps=transfer.sufficiency_gaps()
        return {"admissible":not gaps,"gaps":gaps,"semantics":"missing context is UNKNOWN/UNTRANSFERRED"}
    def reconcile(self,delta:StateDelta):
        return {"returned":True,"reconciled":False,"complete":False,"delta":asdict(delta),"rule":"RETURNED != RECONCILED != COMPLETE"}
