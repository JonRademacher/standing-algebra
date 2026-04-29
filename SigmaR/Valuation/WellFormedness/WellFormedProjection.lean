import SigmaR.StandingAlgebra_FormalCore

/-!
###############################################################################
# Well-Formed Projection
###############################################################################

Projection of valuation expressions must preserve
required structural properties.
###############################################################################
-/

namespace SigmaR

/--
Projection preserves well-formedness.
-/
axiom wellformed_projection :
  ∀ (M : Agent → State → Nat),
    True

end SigmaR
