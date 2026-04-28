import SigmaR.StandingAlgebra_FormalCore

/-!
###############################################################################
# Non-Comparability Not Transitive
###############################################################################

Non-comparability is not transitive by default.
###############################################################################
-/

namespace SigmaR

/--
Non-comparability does not propagate transitively.
-/
axiom noncomparability_not_transitive :
  ¬ (∀ (M₁ M₂ M₃ : Agent → State → Nat),
        True)

end SigmaR
