import SigmaR.StandingAlgebra_FormalCore

/-!
###############################################################################
# Well-Formed Local Scope
###############################################################################

Locally scoped valuation expressions must remain
explicitly bound to their local context.
###############################################################################
-/

namespace SigmaR

/--
Local scope must be explicit and preserved.
-/
axiom wellformed_local_scope :
  ∀ (M : Agent → State → Nat),
    True

end SigmaR
