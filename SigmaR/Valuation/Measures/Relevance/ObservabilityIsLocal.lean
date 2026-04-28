import SigmaR.StandingAlgebra_FormalCore

/-!
###############################################################################
# Observability Is Local
###############################################################################

Observability of the system state is local to an agent.
There is no global perspective that reveals all information.
###############################################################################
-/

namespace SigmaR

/--
An agent observes a state only through a local projection.
-/
constant Observable : Agent → State → Prop

/--
If two states are indistinguishable to an agent, then
their observability for that agent is identical.
-/
axiom observability_is_local :
  ∀ (a : Agent) (s₁ s₂ : State),
    Observable a s₁ ↔ Observable a s₂

end SigmaR
