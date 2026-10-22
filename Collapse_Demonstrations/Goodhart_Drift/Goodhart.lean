/-
  Collapse_Demonstrations.Goodhart_Drift.Goodhart

  This file defines Goodhart drift in isolation, without
  Standing Algebra or any other stabilizing assumptions.

  It is the Lean analogue of:

    Goodhart_System.smt2  →  SAT

  That is: Goodhart drift is a coherent and logically possible
  notion unless additional constraints are imposed.
-/

namespace Collapse_Demonstrations.Goodhart_Drift

/--
  Goodhart drift occurs if there exist two distinct times
  such that the proxy improves while the true value worsens.

  SMT analogue (schematically):

    ∃ t₁ t₂,
      proxy(t₂) > proxy(t₁) ∧
      trueValue(t₂) < trueValue(t₁)
-/
def GoodhartDrift
  (Time : Type)
  (proxy : Time → Int)
  (trueValue : Time → Int) : Prop :=
  ∃ (t₁ t₂ : Time),
    t₁ ≠ t₂ ∧
    proxy t₂ > proxy t₁ ∧
    trueValue t₂ < trueValue t₁

end Collapse_Demonstrations.Goodhart_Drift
