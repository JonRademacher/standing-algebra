import Collapse_Demonstrations.Goodhart_Drift.Goodhart
import SigmaR.SigmaR_Core

/-
  Collapse_Demonstrations.Goodhart_Drift.Goodhart_WithStanding

  This file proves that Goodhart drift is impossible under
  the SAME Standing Algebra axiom used in the SigmaR core.

  This is not a new argument.
  It is a specialization of the collapse-elimination proof.
-/

namespace Collapse_Demonstrations.Goodhart_Drift

/-
  We align Goodhart with SigmaR as follows:

  * Time          ≙ Agent
  * Step/Update   ≙ Operation
  * trueValue     ≙ σ (standing)
  * proxy-improving steps are admissible

  Every carrier and hypothesis below is an explicit argument of the
  theorem: Lean only propagates a `variable` into a declaration when it
  occurs in the declaration's *type*, and these occur only in the proof.
-/

/--
  Under SigmaR Standing Algebra, Goodhart drift is impossible.

  `StandingAlgebra` is the Standing Algebra axiom from the SigmaR core
  (admissible operations do not decrease standing); `ProxyImproves` says a
  proxy‑improving transition is the application of some admissible
  operation.
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
      Admissible F →
      trueValue (Apply F t) ≥ trueValue t)
  (ProxyImproves :
    ∀ t₁ t₂ : Time,
      proxy t₂ > proxy t₁ →
      ∃ F : Operation, Admissible F ∧ Apply F t₁ = t₂) :
  ¬ GoodhartDrift (Time := Time) (proxy := proxy) (trueValue := trueValue) :=
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
  exact absurd hTrueDown (not_lt_of_ge hNonDecrease)

end Collapse_Demonstrations.Goodhart_Drift
