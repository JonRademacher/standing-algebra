import SigmaR.StandingAlgebra_FormalCore
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

/--
Standing is monotone
under admissible operations.
-/
theorem standing_monotone
  (F : Operation) (a : Agent)
  (hAdm : Admissible F) :
  σ a ≤ σ (apply F a) :=
ALRP F a hAdm

end SigmaR
