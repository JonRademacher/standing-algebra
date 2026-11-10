from sigmasolve.methodology import *
def test_eliminated_dependency_blocks_target():
 c1=MethodClaim("A","bad",Provenance("s"),status="REFUTED")
 c2=MethodClaim("T","target",Provenance("s",epistemic_type=EpistemicType.FORMAL_CLAIM),dependencies=["A"],status="OPEN")
 r=MethodologyKernel().review(MethodologyContract("prove T","T",[c1,c2],completion_criteria=["T verified"],verification_contract=["clean replay"]))
 assert r.execution_state==ExecutionState.EXECUTED and r.blocked["T"]==["A"]
def test_epistemic_type_preserved():
 c=MethodClaim("H","candidate",Provenance("s",epistemic_type=EpistemicType.HYPOTHESIS),status="OPEN")
 r=MethodologyKernel().review(MethodologyContract("test","H",[c]))
 assert any("Hypotheses retained" in x for x in r.methodological_findings)
