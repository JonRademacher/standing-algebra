from sigmasolve.models import ProblemContract

def test_contract_roundtrip():
    p=ProblemContract.from_dict({"id":"x","theorem_name":"t","declaration":"theorem t : True","imports":["Mathlib"]})
    assert p.id=="x" and p.imports==("Mathlib",)
    assert p.to_dict()["budget"]["max_rounds"]==3
