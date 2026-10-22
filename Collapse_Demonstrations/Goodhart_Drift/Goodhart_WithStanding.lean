import Collapse_Demonstrations.Goodhart_Drift.Goodhart
import Mathlib.Data.Int.Basic
import SigmaR.StandingAlgebra_FormalCore

/-
  Collapse_Demonstrations.Goodhart_Drift.Goodhart_WithStanding

  This file proves that Goodhart drift is impossible under
  the SAME Standing Algebra axiom used in the SigmaR core.

  This is not a new argument.
  It is a specialization of the collapse-elimination proof.
-/

namespace Collapse_Demonstrations.Goodhart_Drift

/--
  Under SigmaR Standing Algebra, Goodhart drift is impossible.
-/
theorem noGoodhartDrift_under_StandingAlgebra
  (Time : Type)
  (Operation : Type)
  (proxy : Time → Int)
  (trueValue : Time → Int)
  (Apply : Operation → Time → Time)
  (Admissible : Operation → Prop)
  (StandingAlgebra :
    ∀ (F : Operation) (t : Time),
      Admissible F → trueValue (Apply F t) ≥ trueValue t)
  (ProxyImproves :
    ∀ t₁ t₂ : Time,
      proxy t₂ > proxy t₁ →
      ∃ F : Operation, Admissible F ∧ Apply F t₁ = t₂) :
  ¬ GoodhartDrift Time proxy trueValue :=
by
  intro hDrift
  rcases hDrift with ⟨t₁, t₂, hNe, hProxyUp, hTrueDown⟩

  -- From proxy improvement, get an admissible operation
  rcases ProxyImproves t₁ t₂ hProxyUp with ⟨F, hAdm, hApply⟩
  subst hApply

  -- Standing Algebra forbids true-value decrease
  have hNonDecrease : trueValue (Apply F t₁) ≥ trueValue t₁ :=
    StandingAlgebra F t₁ hAdm

  -- Contradiction: decrease and non-decrease
  exact (Int.not_lt.mpr hNonDecrease) hTrueDown

end Collapse_Demonstrations.Goodhart_Drift
