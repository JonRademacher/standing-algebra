from __future__ import annotations
from dataclasses import dataclass,field,asdict
from typing import Any

@dataclass
class Representation:
    id:str; statement:str; relation_to_target:str; obligations:list[str]=field(default_factory=list); status:str="CANDIDATE"; evidence:dict[str,Any]=field(default_factory=dict)

class RepresentationPortfolio:
    def __init__(self,target:str): self.target=target; self.items=[]
    def add(self,item:Representation): self.items.append(item)
    def admissible(self): return [x for x in self.items if x.status not in {"REFUTED","ENCODING_INVALID"}]
    def report(self): return {"target":self.target,"representations":[asdict(x) for x in self.items],"survivors":[x.id for x in self.admissible()]}
