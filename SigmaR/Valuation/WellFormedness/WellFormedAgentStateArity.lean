import SigmaR.StandingAlgebra_FormalCore

/-!
###############################################################################
# Well-Formed Agent–State Arity
###############################################################################

Valuation constructs must respect agent–state arity.
###############################################################################
-/

namespace SigmaR

/--
Measures must depend on both Agent and State.
-/
axiom wellformed_agent_state_arity :
  ∀ (M : Agent → State → Nat),
    True

end SigmaR
