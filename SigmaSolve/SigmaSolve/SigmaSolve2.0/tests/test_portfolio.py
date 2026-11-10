from sigmasolve.portfolio import RepresentationPortfolio,Representation
def test_portfolio():
 p=RepresentationPortfolio("T"); p.add(Representation("a","A","equivalent",status="REFUTED")); p.add(Representation("b","B","implies")); assert [x.id for x in p.admissible()]==["b"]
