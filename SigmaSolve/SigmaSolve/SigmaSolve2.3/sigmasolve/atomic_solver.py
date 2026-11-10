from __future__ import annotations
from dataclasses import dataclass, asdict
from pathlib import Path
from collections import defaultdict
import json

VALID={"ESTABLISHED","ESTABLISHED_NEEDS_LIBRARY_BINDING","VALID","VALID_CONDITIONAL","SALVAGEABLE_REFORMULATION","PLAUSIBLE_NEEDS_PROOF","OPEN"}
ELIMINATED={"REFUTED","REFUTED_AS_STATED","REFUTED_AS_PROVED","REFUTED_AS_GENERAL_PRINCIPLE","REFUTED_AS_INFERENCE","REFUTED_AS_DERIVED","NON_SEQUITUR_FOR_RH"}
PROVED={"ESTABLISHED","VALID"}

@dataclass
class AtomicRun:
    target:str
    terminal_state:str
    proved:list[str]
    conditional:list[str]
    blocked:dict[str,list[str]]
    eliminated:list[str]
    frontier:list[dict]
    repairs:list[dict]
    invariants:list[str]

class AtomicClaimSolver:
    def __init__(self,claims):
        self.claims={c["id"]:c for c in claims}
    @classmethod
    def load(cls,path):
        p=Path(path); rows=[]
        if p.suffix=='.jsonl':
            rows=[json.loads(x) for x in p.read_text().splitlines() if x.strip()]
        else: rows=json.loads(p.read_text())
        return cls(rows)
    def run(self,target="C007"):
        proved={i for i,c in self.claims.items() if c["status"] in PROVED}
        eliminated={i for i,c in self.claims.items() if c["status"] in ELIMINATED}
        changed=True
        while changed:
            changed=False
            for i,c in self.claims.items():
                if i in proved or i in eliminated: continue
                deps=c.get("dependencies",[])
                if c["status"]=="VALID_CONDITIONAL" and all(d in proved for d in deps):
                    proved.add(i); changed=True
        blocked={}
        for i,c in self.claims.items():
            bad=[d for d in c.get("dependencies",[]) if d in eliminated or d not in proved]
            if bad and i not in eliminated: blocked[i]=bad
        repairs=[]
        for i in sorted(eliminated | set(blocked)):
            c=self.claims[i]
            if c.get("next_test"):
                repairs.append({"claim":i,"test":c["next_test"],"preserves_target":True})
        frontier=[]
        for i,c in self.claims.items():
            if i in proved or i in eliminated: continue
            frontier.append({"claim":i,"statement":c["statement"],"status":c["status"],"missing":blocked.get(i,[]),"next_test":c.get("next_test")})
        state="PROVED" if target in proved else "UNRESOLVED"
        return AtomicRun(target,state,sorted(proved),sorted(set(self.claims)-proved-eliminated-set(blocked)),blocked,sorted(eliminated),frontier,repairs,[
          "No proof may depend on an eliminated claim.",
          "No subseries inherits the value of a full series without a residual theorem.",
          "Symmetry of a zero set does not force pointwise fixedness.",
          "Bounded certificates do not discharge a universal height quantifier.",
          "The full target remains unchanged under repair."
        ])

def save_run(run,path): Path(path).write_text(json.dumps(asdict(run),indent=2),encoding='utf-8')
