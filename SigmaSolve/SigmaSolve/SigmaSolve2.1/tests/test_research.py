from sigmasolve.research import symbolic_check
def test_symbolic_is_typed():
 r=symbolic_check("(x+1)**2-(x**2+2*x+1)"); assert r.claim_scope and isinstance(r.limitations,list)
