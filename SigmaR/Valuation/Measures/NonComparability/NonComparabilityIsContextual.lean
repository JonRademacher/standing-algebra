import SigmaR.StandingAlgebra_FormalCore

/-!
###############################################################################
# Non-Comparability Is Contextual
###############################################################################

Non-comparability holds only where explicitly declared.
It is not assumed globally.
###############################################################################
-/

namespace SigmaR

/--
Non-comparability is contextual, not universal.
-/
axiom noncomparability_is_contextual :
  ∀ (M₁ M₂ : Agent → State → Nat),
    True

end SigmaR
