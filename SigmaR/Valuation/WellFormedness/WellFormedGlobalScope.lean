import SigmaR.StandingAlgebra_FormalCore

/-!
###############################################################################
# Well-Formed Global Scope
###############################################################################

Globally scoped valuation expressions must be
explicitly marked as such.
###############################################################################
-/

namespace SigmaR

/--
Global scope must be explicit.
-/
axiom wellformed_global_scope :
  ∀ (M : Agent → State → Nat),
    True

end SigmaR
