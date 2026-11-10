from dataclasses import dataclass
@dataclass(frozen=True)
class ZeroOccurrence:
    label: object
    multiplicity: int
    on_line: bool
class ZeroCertificate:
    def __init__(self,xs):
        self.xs=tuple(xs)
        if any(x.multiplicity<=0 for x in self.xs): raise ValueError("positive multiplicity required")
    @property
    def N(self): return sum(x.multiplicity for x in self.xs)
    @property
    def N0(self): return sum(x.multiplicity for x in self.xs if x.on_line)
    def all_on_line(self): return all(x.on_line for x in self.xs)
    def laws(self): return self.N0<=self.N and ((self.N0==self.N)==self.all_on_line())
