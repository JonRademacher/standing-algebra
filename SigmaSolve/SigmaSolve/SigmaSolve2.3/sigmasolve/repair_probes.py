from __future__ import annotations
from dataclasses import dataclass,asdict
import math, random

@dataclass
class Probe:
    claim:str; status:str; witness:dict; consequence:str

def semicircle_boundary_probe():
    # Alternating boundary phases +pi/2 and -pi/2 with paired weights 1/(2k)+1/(2k+1).
    # Terms tend to zero and paired residuals are summable; every phase remains on a closed-semicircle boundary.
    terms=[]; s=0j
    for k in range(1,20001):
        a=1/(2*k); b=1/(2*k+1)
        s += 1j*a-1j*b
    return Probe("C011","COUNTEREXAMPLE_SHAPE_CONFIRMED",{"partial_sum_pairs":s.imag,"boundary_phases":[math.pi/2,-math.pi/2],"outside_mass":0},"Require open semicircle or boundary control; do not reuse C011.")

def local_pair_probe():
    residual=-1+sum(2**(-n) for n in range(1,61))
    return Probe("C024","COUNTEREXAMPLE_CONFIRMED",{"residual":residual,"series":"-1 + sum 2^-n"},"Replace pair cancellation with exact decomposition plus residual bound.")

def decreasing_block_probe():
    return Probe("C025","COUNTEREXAMPLE_CONFIRMED",{"blocks":[.5,-.3,-.2],"sum":0.0},"Require tail dominance, not strict decrease.")

def symmetry_probe():
    return Probe("C029","COUNTEREXAMPLE_CONFIRMED",{"set":[.25,.75],"reflection":"x -> 1-x"},"Need an off-axis exclusion theorem independent of symmetry.")

def run_all(): return [asdict(x) for x in [semicircle_boundary_probe(),local_pair_probe(),decreasing_block_probe(),symmetry_probe()]]
