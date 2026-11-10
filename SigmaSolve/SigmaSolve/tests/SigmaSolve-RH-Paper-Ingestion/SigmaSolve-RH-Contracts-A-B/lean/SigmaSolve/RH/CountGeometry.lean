import Mathlib
import SigmaSolve.RH.ZetaPredicateBinding

namespace SigmaSolve.RH
open Complex
noncomputable section

/-- Total multiplicity represented by a finite multiset certificate. -/
def N (zeros : Multiset ℂ) : ℕ := zeros.card

/-- Multiplicity represented on the critical line. -/
def N0 (zeros : Multiset ℂ) : ℕ :=
  (zeros.filter OnCriticalLine).card

/-- Every occurrence in the finite certificate lies on the critical line. -/
def AllOnCriticalLine (zeros : Multiset ℂ) : Prop :=
  ∀ ρ ∈ zeros, OnCriticalLine ρ

theorem n0_le_n (zeros : Multiset ℂ) : N0 zeros ≤ N zeros := by
  classical
  simpa [N0, N] using Multiset.card_filter_le zeros OnCriticalLine

theorem n0_eq_n_iff (zeros : Multiset ℂ) :
    N0 zeros = N zeros ↔ AllOnCriticalLine zeros := by
  classical
  induction zeros using Multiset.induction_on with
  | empty => simp [N0, N, AllOnCriticalLine]
  | @cons ρ zeros ih =>
      by_cases h : OnCriticalLine ρ
      · simp [N0, N, AllOnCriticalLine, h, ih]
      · simp [N0, N, AllOnCriticalLine, h]

theorem bounded_completeness
    (zeros : Multiset ℂ)
    (hcount : N0 zeros = N zeros) :
    AllOnCriticalLine zeros :=
  (n0_eq_n_iff zeros).mp hcount

end
end SigmaSolve.RH
