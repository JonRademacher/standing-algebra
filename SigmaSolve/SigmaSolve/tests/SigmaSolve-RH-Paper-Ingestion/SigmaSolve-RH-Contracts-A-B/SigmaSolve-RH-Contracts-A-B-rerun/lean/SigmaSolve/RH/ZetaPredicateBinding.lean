import Mathlib
import SigmaSolve.RH.BoundedGlobalBridge

namespace SigmaSolve.RH
open Complex

/-- Explicit zeta-zero predicate. -/
def IsZetaZero (ρ : ℂ) : Prop := riemannZeta ρ = 0

/-- Critical-strip zero predicate. This is the direct RH target used by this package.
The separate equivalence to any repository-level `RiemannHypothesis` definition is
kept as an explicit integration obligation. -/
def IsNontrivialZero (ρ : ℂ) : Prop :=
  IsZetaZero ρ ∧ 0 < ρ.re ∧ ρ.re < 1

def OnCriticalLine (ρ : ℂ) : Prop := ρ.re = (1 : ℝ) / 2

/-- Contract A: the exact global statement is equivalent to all bounded windows. -/
theorem zeta_global_iff_all_bounded :
    (∀ ρ, IsNontrivialZero ρ → OnCriticalLine ρ) ↔
      (∀ T : ℝ, 0 < T → ∀ ρ,
        IsNontrivialZero ρ → |ρ.im| ≤ T → OnCriticalLine ρ) := by
  simpa using global_iff_all_bounded IsNontrivialZero OnCriticalLine

end SigmaSolve.RH
