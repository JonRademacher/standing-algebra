from __future__ import annotations
from dataclasses import dataclass,asdict
from pathlib import Path
import json, math

@dataclass
class ResearchResult:
    backend:str; status:str; claim_scope:str; evidence:dict; limitations:list[str]

def symbolic_check(expression: str) -> ResearchResult:
    try:
        import sympy as s
        expr=s.sympify(expression); simplified=s.simplify(expr)
        return ResearchResult("sympy","COMPUTED","symbolic identity/candidate only",{"input":expression,"simplified":str(simplified)},["Symbolic simplification is not automatically a Lean proof","Domain conditions may be implicit"])
    except Exception as e: return ResearchResult("sympy","BACKEND_UNAVAILABLE_OR_ERROR","none",{"error":str(e)},[])

def z3_smt2(smt2: str) -> ResearchResult:
    try:
        import z3
        solver=z3.Solver(); solver.from_string(smt2); status=solver.check(); evidence={"status":str(status)}
        if status==z3.sat: evidence["model"]=str(solver.model())
        return ResearchResult("z3",str(status).upper(),"declared SMT formula",evidence,["SMT satisfiability is relative to the encoding","Not a proof of an unencoded analytic statement"])
    except Exception as e: return ResearchResult("z3","BACKEND_UNAVAILABLE_OR_ERROR","none",{"error":str(e)},[])

def zeta_zero_scan(t_start:float,t_end:float,steps:int=1000,dps:int=50) -> ResearchResult:
    try:
        import mpmath as mp
        mp.mp.dps=dps; zeros=[]
        # Gram-index scan: check known ordinate generator within interval.
        n=1
        while len(zeros)<steps:
            z=mp.zetazero(n); t=float(mp.im(z))
            if t>t_end: break
            if t>=t_start: zeros.append({"n":n,"real":float(mp.re(z)),"imag":t,"critical_line_error":abs(float(mp.re(z))-0.5)})
            n+=1
        return ResearchResult("mpmath","FINITE_SCAN_COMPLETE","finite listed zeros only",{"interval":[t_start,t_end],"dps":dps,"zeros":zeros,"count":len(zeros)},["Finite verification cannot prove RH","mpmath numerical output is not a certified interval proof"])
    except Exception as e: return ResearchResult("mpmath","BACKEND_UNAVAILABLE_OR_ERROR","none",{"error":str(e)},[])

def write_result(result:ResearchResult,path:str|Path): Path(path).write_text(json.dumps(asdict(result),indent=2),encoding="utf-8")
