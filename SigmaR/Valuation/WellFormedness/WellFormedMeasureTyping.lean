import SigmaR.StandingAlgebra_FormalCore

/-!
###############################################################################
# Well-Formed Measure Typing
###############################################################################

Valuation measures must have the correct functional type.
###############################################################################
-/

namespace SigmaR

/--
A valuation measure maps an Agent and a State to a value.
-/
axiom wellformed_measure_typing :
  ∀ (M : Agent → State → Nat),
    True

end SigmaR
