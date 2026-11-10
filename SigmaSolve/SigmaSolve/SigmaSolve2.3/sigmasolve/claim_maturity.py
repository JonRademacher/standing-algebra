from __future__ import annotations
from dataclasses import dataclass,field,asdict
from typing import Any

@dataclass
class ClaimMaturity:
    generated:bool=False
    executed:bool=False
    formally_verified:bool=False
    clean_replayed:bool=False
    internally_reproduced:bool=False
    independently_reproduced:bool=False
    peer_reviewed:bool=False
    contested:list[str]=field(default_factory=list)

    def label(self):
        if self.peer_reviewed:return "peer_reviewed"
        if self.independently_reproduced:return "independently_reproduced"
        if self.internally_reproduced:return "internally_reproduced"
        if self.clean_replayed:return "clean_replayed"
        if self.formally_verified:return "formally_verified"
        if self.executed:return "executed"
        if self.generated:return "generated"
        return "uninstantiated"

def verification_not_validation(formal_acceptance:bool, construct_validated:bool):
    return {"verification":formal_acceptance,"validation":construct_validated,"equivalent":False,"warning":"Verified execution does not validate the construct, model, encoding, originality, or real-world applicability."}
