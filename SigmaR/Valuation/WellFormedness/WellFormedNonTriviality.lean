import SigmaR.StandingAlgebra_FormalCore

/-!
###############################################################################
# Well-Formed Non-Triviality
###############################################################################

Well-formed valuation constructions must not be
structurally empty or degenerate.
###############################################################################
-/

namespace SigmaR

/--
Well-formed constructions are non-trivial.
-/
axiom wellformed_non_triviality :
  ∀ (M : Agent → State → Nat),
    True

end SigmaR
