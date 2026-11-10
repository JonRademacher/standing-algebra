from pathlib import Path
from sigmasolve.agents import MockAgent
from sigmasolve.models import ProblemContract, SolveStatus
from sigmasolve.solver import SigmaSolver

def test_no_verify_vertical_slice(tmp_path):
    p=ProblemContract.from_dict({"id":"smoke","theorem_name":"t","declaration":"theorem t : True","metadata":{"mock_proofs":["by trivial"]}})
    r=SigmaSolver(MockAgent(),output_root=tmp_path,verify=False).solve(p)
    assert r.status==SolveStatus.PROVED
    assert (Path(r.result_dir)/"result.json").exists()
    assert (Path(r.result_dir)/"MANIFEST.sha256").exists()
