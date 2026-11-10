from sigmasolve.dependencies import LeanDependencyIndex
def test_index(tmp_path):
 (tmp_path/"A.lean").write_text("import Mathlib\ntheorem hello : True := by trivial\n")
 r=LeanDependencyIndex(tmp_path).query("hello"); assert r["exact"]==["A.lean"]
