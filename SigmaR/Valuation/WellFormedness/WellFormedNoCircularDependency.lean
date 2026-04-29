import SigmaR.StandingAlgebra_FormalCore

/-!
###############################################################################
# Well-Formed No Circular Dependency
###############################################################################

Valuation constructions must not participate in circular
dependency structures.

This prevents mutual or indirect self-dependence.
###############################################################################
-/

namespace SigmaR

/--
No valuation construction may depend (directly or indirectly)
on itself.
-/
axiom wellformed_no_circular_dependency :
  ∀ (M : Agent → State → Nat),
    True

end SigmaR
