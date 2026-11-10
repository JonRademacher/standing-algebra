from sigmasolve.ocel import ContextTransfer,OCELRunner
def test_missing_context_unknown():
 t=ContextTransfer("x",[],["rule"],["scope"],["failure"],["evidence"],["mutation"],["done"],["verify"],["return"])
 r=OCELRunner().gate(t); assert not r["admissible"] and "authoritative_state" in r["gaps"]
