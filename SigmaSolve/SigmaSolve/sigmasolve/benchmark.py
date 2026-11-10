from __future__ import annotations
from pathlib import Path
import json, time
from .models import ProblemContract
from .solver import SigmaSolver

def run_benchmark(path: str | Path, solver: SigmaSolver) -> dict:
    spec=json.loads(Path(path).read_text(encoding="utf-8")); results=[]
    for item in spec["problems"]:
        problem=ProblemContract.from_json(Path(path).parent/item) if isinstance(item,str) else ProblemContract.from_dict(item)
        started=time.time(); result=solver.solve(problem)
        results.append({"problem_id":problem.id,"status":result.status.value,"seconds":time.time()-started,**result.summary})
    proved=sum(r["status"]=="PROVED" for r in results)
    return {"benchmark":spec.get("name","unnamed"),"condition":spec.get("condition","C3"),"problems":len(results),"proved":proved,"success_rate":proved/len(results) if results else 0.0,"results":results}
