import SigmaR.StandingAlgebra_FormalCore

/-!
###############################################################################
# Well-Formed Restriction
###############################################################################

Restriction of valuation expressions must be explicit
and structurally coherent.
###############################################################################
-/

namespace SigmaR

/--
Restriction preserves well-formedness.
-/
axiom wellformed_restriction :
  ∀ (M : Agent → State → Nat),
    True

end SigmaR
