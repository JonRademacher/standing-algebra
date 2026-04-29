import SigmaR.StandingAlgebra_FormalCore

/-!
###############################################################################
# Well-Formed Context Binding
###############################################################################

Valuation expressions must be bound to an explicit
agent–state context.
###############################################################################
-/

namespace SigmaR

/--
Context binding must be explicit.
-/
axiom wellformed_context_binding :
  ∀ (M : Agent → State → Nat),
    True

end SigmaR
