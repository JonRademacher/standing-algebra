import SigmaR.StandingAlgebra_FormalCore

/-!
###############################################################################
# No Dominance Between Measures
###############################################################################

Non-comparable measures admit no dominance relation.
###############################################################################
-/

namespace SigmaR

/--
No measure dominates another by default.
-/
axiom no_dominance_between_measures :
  ∀ (M₁ M₂ : Agent → State → Nat),
    ¬ (∀ a s, M₁ a s ≥ M₂ a s)

end SigmaR
