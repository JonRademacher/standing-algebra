from sigmasolve.classify import classify
from sigmasolve.models import VerificationResult, SolveStatus

def vr(stderr="", status=SolveStatus.UNRESOLVED, rejected=None):
    return VerificationResult(False,status,[],1,"",stderr,0,"","",rejected_tokens=rejected or [])

def test_type_mismatch():
    assert classify(vr("error: type mismatch"))[0]=="type_mismatch"

def test_forbidden():
    assert classify(vr(rejected=["sorry"]))[0]=="unsafe_escape"
