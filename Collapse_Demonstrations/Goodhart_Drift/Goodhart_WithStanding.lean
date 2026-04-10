/-
  Collapse_Demonstrations.Goodhart_Drift.Goodhart_WithStanding

  Lean analogue of:

    Goodhart_With_StandingAlgebra.smt2  →  UNSAT

  This file proves that under Standing Algebra–style mathematical
  constraints, Goodhart drift is impossible.

  The proof is entirely structural: it shows that the inequalities
  required for Goodhart drift contradict the algebraic assumptions.
-/

namespace Collapse_Demonstrations.Goodhart_Drift

-- Import the Goodhart drift definition
import Collapse_Demonstrations.Goodhart_Drift.Goodhart

/--
  Abstract time index.
-/
variable (Time : Type)

/--
  Proxy metric and true value.
-/
variable
  (proxy : Time → Int)
  (trueValue : Time → Int)

/--
  Standing Algebra–style assumptions for Goodhart:

  1. Proxy improvement is monotone (optimization pressure)
  2. True value is monotone (standing cannot decrease)
-/
def GoodhartStandingAlgebra : Prop :=
  (∀ t₁ t₂ : Time, proxy t₂ > proxy t₁ → trueValue t₂ ≥ trueValue t₁)

/--
  Under Standing Algebra constraints, Goodhart drift is impossible.
-/
theorem noGoodhartDrift_under_StandingAlgebra
  (SA : GoodhartStandingAlgebra Time proxy trueValue) :
  ¬ GoodhartDrift Time proxy trueValue :=
by
  intro hDrift
  rcases hDrift with ⟨t₁, t₂, hNe, hProxyUp, hTrueDown⟩

  -- From Standing Algebra, proxy increase implies true value non-decrease
  have hTrueNonDecrease : trueValue t₂ ≥ trueValue t₁ :=
    SA t₁ t₂ hProxyUp

  -- Contradiction: trueValue t₂ < trueValue t₁ and ≥ trueValue t₁
  exact lt_irrefl _ (lt_of_lt_of_le hTrueDown hTrueNonDecrease)

end Collapse_Demonstrations.Goodhart_Drift
