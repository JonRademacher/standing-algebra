/-
  Collapse_Demonstrations.Goodhart_Drift.Goodhart_WithStanding

  This file proves that Goodhart drift is impossible under
  the SAME Standing Algebra axiom used in the SigmaR core.

  This is not a new argument.
  It is a specialization of the collapse-elimination proof.
-/

namespace Collapse_Demonstrations.Goodhart_Drift

-- Import the Goodhart drift definition
import Collapse_Demonstrations.Goodhart_Drift.Goodhart

-- Import SigmaR core Standing Algebra
-- Adjust the import path if your core file name differs
import SigmaR.SigmaR_Core

/--
  We align Goodhart with SigmaR as follows:

  * Time          ≙ Agent
  * Step/Update   ≙ Operation
  * trueValue     ≙ σ (standing)
  * proxy-improving steps are admissible
-/
variable
  (Time : Type)
  (Operation : Type)

/-- True value = standing function σ -/
variable
  (trueValue : Time → Int)

/-- Application of an operation to a time state -/
variable
  (Apply : Operation → Time → Time)

/-- Admissibility of an operation -/
variable
  (Admissible : Operation → Prop)

/--
  Standing Algebra axiom (from SigmaR core):

  Admissible operations do not decrease standing.
-/
variable
  (StandingAlgebra :
    ∀ (F : Operation) (t : Time),
      Admissible F →
      trueValue (Apply F t) ≥ trueValue t)

/--
  Proxy improvement assumption:

  A Goodhart proxy-improving transition corresponds
  to applying some admissible operation.
-/
variable
  (ProxyImproves :
    ∀ t₁ t₂ : Time,
      proxy t₂ > proxy t₁ →
      ∃ F : Operation, Admissible F ∧ Apply F t₁ = t₂)

/--
  Under SigmaR Standing Algebra, Goodhart drift is impossible.
-/
theorem noGoodhartDrift_under_StandingAlgebra :
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
  exact lt_irrefl _ (lt_of_lt_of_le hTrueDown hNonDecrease)

end Collapse_Demonstrations.Goodhart_Drift
