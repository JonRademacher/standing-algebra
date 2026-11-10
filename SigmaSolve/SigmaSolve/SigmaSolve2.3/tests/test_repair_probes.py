from sigmasolve.repair_probes import run_all
def test_probes():
 r=run_all(); assert len(r)==4 and all("COUNTEREXAMPLE" in x["status"] for x in r)
