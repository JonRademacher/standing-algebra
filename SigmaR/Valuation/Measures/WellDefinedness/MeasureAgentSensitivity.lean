import SigmaR.StandingAlgebra_FormalCore

/-!
###############################################################################
# Measure Agent Sensitivity
###############################################################################

Agent-indexed measures must depend on the agent dimension.
They may coincide for some agents, but not all.
###############################################################################
-/

namespace SigmaR

/--
An agent-indexed valuation measure must depend on agent identity.
-/
axiom measure_agent_sensitive :
  ∀ (M : Agent → State → Nat),
    ∃ (a₁ a₂ : Agent) (s : State),
      M a₁ s ≠ M a₂ s

end SigmaR
