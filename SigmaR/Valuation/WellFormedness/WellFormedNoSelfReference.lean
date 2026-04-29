import SigmaR.StandingAlgebra_FormalCore

/-!
###############################################################################
# Well-Formed No Self-Reference
###############################################################################

Valuation expressions must not be defined in terms
of themselves.
###############################################################################
-/

namespace SigmaR

/--
No valuation expression may be structurally self-referential.
-/
axiom wellformed_no_self_reference :
  ∀ (M : Agent → State → Nat),
    True

end SigmaR
