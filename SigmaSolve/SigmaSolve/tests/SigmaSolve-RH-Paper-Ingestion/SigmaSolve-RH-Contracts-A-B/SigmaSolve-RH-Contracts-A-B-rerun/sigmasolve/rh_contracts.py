from dataclasses import dataclass
from typing import Hashable, Iterable

@dataclass(frozen=True)
class ZeroOccurrence:
    zero: Hashable
    imaginary: float
    multiplicity: int
    on_critical_line: bool

class BoundedZeroCertificate:
    def __init__(self, height: float, occurrences: Iterable[ZeroOccurrence]):
        if height <= 0:
            raise ValueError("height must be positive")
        self.height = float(height)
        self.occurrences = tuple(occurrences)
        if any(x.multiplicity <= 0 for x in self.occurrences):
            raise ValueError("multiplicity must be positive")
        if any(abs(x.imaginary) > self.height for x in self.occurrences):
            raise ValueError("certificate contains an occurrence outside its window")

    @property
    def N(self):
        return sum(x.multiplicity for x in self.occurrences)

    @property
    def N0(self):
        return sum(x.multiplicity for x in self.occurrences if x.on_critical_line)

    def all_on_line(self):
        return all(x.on_critical_line for x in self.occurrences)

    def count_laws(self):
        return self.N0 <= self.N and ((self.N0 == self.N) == self.all_on_line())


def global_iff_all_bounded(zeros):
    zeros = tuple(zeros)
    global_property = all(on_line for _, imag, on_line in zeros)
    bounds = [1.0] + [abs(imag) + 1.0 for _, imag, _ in zeros]
    bounded_property = all(
        all(on_line for _, imag, on_line in zeros if abs(imag) <= T)
        for T in bounds
    )
    return global_property == bounded_property
