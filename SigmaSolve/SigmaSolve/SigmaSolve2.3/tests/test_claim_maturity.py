from sigmasolve.claim_maturity import *
def test_verification_not_validation():
 r=verification_not_validation(True,False); assert r["verification"] and not r["validation"] and not r["equivalent"]
