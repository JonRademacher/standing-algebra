import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Core.StructuralInterfaces

/-!
###############################################################################
# Partial Observability
###############################################################################

Not all aspects of the system are observable
by any agent at any time.

Each agent has blind spots.
###############################################################################
-/

namespace SigmaR

/--
Observability is partial: for every agent, there exist
states that are not observable to that agent.
-/
axiom partial_observability :
  ∀ (a : Agent),
    ∃ (s : State),
      ¬ Observable a s

end SigmaR
