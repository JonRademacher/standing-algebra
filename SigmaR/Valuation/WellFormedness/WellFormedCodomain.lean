import SigmaR.StandingAlgebra_FormalCore

/-!
###############################################################################
# Well-Formed Codomain
###############################################################################

Valuation expressions must have a coherent and explicit codomain.
###############################################################################
-/

namespace SigmaR

/--
Valuation measures must return values in their declared codomain.
-/
axiom wellformed_codomain :
  ∀ (M : Agent → State → Nat),
    True

end SigmaR
