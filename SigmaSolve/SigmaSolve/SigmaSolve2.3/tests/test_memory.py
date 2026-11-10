from sigmasolve.memory import TheoremMemory
def test_memory(tmp_path):
 m=TheoremMemory(tmp_path/"m.db"); m.add("lemma","x=x",{"proof":"rfl"},{"lean":True},verified=True); assert m.search("x=x")[0]["verified"]
