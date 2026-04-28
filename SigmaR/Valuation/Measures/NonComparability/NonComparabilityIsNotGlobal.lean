import SigmaR.StandingAlgebra_FormalCore

/-!
###############################################################################
# Non-Comparability Is Not Global
###############################################################################

Non-comparability does not apply to all measures
in all contexts by default.
###############################################################################
-/

namespace SigmaR

/--
Non-comparability is not globally asserted.
-/
axiom noncomparability_not_global :
  ¬ (∀ (M₁ M₂ : Agent → State → Nat),
        True)

end SigmaR
