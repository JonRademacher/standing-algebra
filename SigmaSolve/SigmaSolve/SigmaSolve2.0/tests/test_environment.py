from sigmasolve.environment import doctor
def test_doctor():
 r=doctor(); assert "capabilities" in r and "lean_ready" in r
