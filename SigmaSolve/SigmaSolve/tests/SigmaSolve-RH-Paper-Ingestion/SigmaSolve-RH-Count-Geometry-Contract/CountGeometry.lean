import Mathlib

namespace SigmaSolve.RH
open Complex
noncomputable section

def OnCriticalLine (rho : Complex) : Prop := rho.re = (1 : Real) / 2
def N (zeros : Multiset Complex) : Nat := zeros.card
def N0 (zeros : Multiset Complex) : Nat := (zeros.filter OnCriticalLine).card
def AllOnCriticalLine (zeros : Multiset Complex) : Prop := forall rho in zeros, OnCriticalLine rho

theorem n0_le_n (zeros : Multiset Complex) : N0 zeros <= N zeros := by
  classical
  simpa [N0, N] using Multiset.card_filter_le zeros OnCriticalLine

theorem n0_eq_n_iff (zeros : Multiset Complex) :
    N0 zeros = N zeros <-> AllOnCriticalLine zeros := by
  classical
  induction zeros using Multiset.induction_on with
  | empty => simp [N0, N, AllOnCriticalLine]
  | @cons rho zeros ih =>
      by_cases h : OnCriticalLine rho
      . simp [N0, N, AllOnCriticalLine, h, ih]
      . simp [N0, N, AllOnCriticalLine, h]

theorem bounded_completeness (zeros : Multiset Complex)
    (h : N0 zeros = N zeros) : AllOnCriticalLine zeros :=
  (n0_eq_n_iff zeros).mp h

end
end SigmaSolve.RH
