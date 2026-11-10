from sigmasolve.models import ProblemContract, Candidate
from sigmasolve.verifiers import LeanVerifier

def test_forbidden_token_rejected_before_execution():
    p=ProblemContract.from_dict({"id":"x","theorem_name":"t","declaration":"theorem t : True"})
    r=LeanVerifier(executable=None).verify(p,Candidate("by sorry","bad"))
    assert not r.accepted and "sorry" in r.rejected_tokens
