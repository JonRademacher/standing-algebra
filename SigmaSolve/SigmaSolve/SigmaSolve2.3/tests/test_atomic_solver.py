import json
from sigmasolve.atomic_solver import AtomicClaimSolver
def test_refuted_dependency_cannot_close(tmp_path):
 p=tmp_path/"c.json"; p.write_text(json.dumps([{"id":"A","status":"REFUTED","dependencies":[],"statement":"bad"},{"id":"T","status":"VALID_CONDITIONAL","dependencies":["A"],"statement":"target"}]))
 r=AtomicClaimSolver.load(p).run("T"); assert r.terminal_state=="UNRESOLVED" and r.blocked["T"]==["A"]
