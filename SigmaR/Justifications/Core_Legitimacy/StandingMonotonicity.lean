module SigmaR.Justifications.Core_Legitimacy.StandingMonotonicity

import SigmaR.Core.StandingValuation
import SigmaR.Justifications.Core_Legitimacy.LegitimacyCharacterization

/-!
###############################################################################
# Standing Monotonicity Under Structural Admissibility
###############################################################################

Standing is defined as:

  σ(s,i)
    =
    w₁ * CIA(s,i)
    - w₂ * deg(s,i)
    - w₃ * RiskLoad(s,i)
    + w₄ * ExitViable(s,i)

with:

  w₁, w₂, w₃, w₄ ≥ 0.

Structurally admissible operations preserve:

  • CIA (non‑decreasing)
  • dependency (non‑increasing)
  • risk exposure (non‑increasing)
  • exit viability (non‑decreasing)

Therefore:

  σ is monotone under structurally admissible operations.
-/

namespace SigmaR

variables
  (w₁ w₂ w₃ w₄ : ℝ)
  (hw₁ : 0 ≤ w₁)
  (hw₂ : 0 ≤ w₂)
  (hw₃ : 0 ≤ w₃)
  (hw₄ : 0 ≤ w₄)

/--
Standing is monotone
under structurally admissible operations.
-/
theorem standing_monotone :
  ∀ {F : Operation} {s : State} {i : Agent},
    StructurallyAdmissible F s →
    σ (apply F s) i ≥ σ s i :=
begin
  intros F s i hAdm,

  unfold σ,

  have hCIA :
    CIA (apply F s) i ≥ CIA s i,
    from CIA_monotone hAdm,

  have hDeg :
    deg (apply F s) i ≤ deg s i,
    from dependency_bounded hAdm,

  have hRisk :
    RiskLoad (apply F s) i ≤ RiskLoad s i,
    from risk_preserved hAdm,

  have hExit :
    ExitViable (apply F s) i ≥ ExitViable s i,
    from exit_preserved hAdm,

  linarith
end

end SigmaR
