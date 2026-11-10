from dataclasses import dataclass
from typing import Iterable

@dataclass(frozen=True)
class ZeroWitness:
    height: float
    multiplicity: int
    on_line: bool

class OffLineDefect:
    def __init__(self, zeros: Iterable[ZeroWitness]):
        self.zeros=tuple(zeros)
        if any(z.height < 0 or z.multiplicity <= 0 for z in self.zeros):
            raise ValueError("height must be nonnegative and multiplicity positive")
    def O(self,T:float)->int:
        return sum(z.multiplicity for z in self.zeros if z.height <= T and not z.on_line)
    def monotone_on(self,Ts):
        vals=[self.O(T) for T in Ts]
        return all(a<=b for a,b in zip(vals,vals[1:]))
    def first_jump(self):
        bad=[z for z in self.zeros if not z.on_line]
        if not bad:return None
        h=min(z.height for z in bad)
        return {"height":h,"jump":sum(z.multiplicity for z in bad if z.height==h)}
    def rh_on_landscape(self):
        return all(z.on_line for z in self.zeros)
    def zero_defect_all_relevant_windows(self):
        Ts=[0.0]+[z.height for z in self.zeros]+[z.height+1 for z in self.zeros]
        return all(self.O(T)==0 for T in Ts)
    def equivalence(self):
        return self.rh_on_landscape()==self.zero_defect_all_relevant_windows()
