import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Measures.Relevance.ObservabilityIsLocal

/-!
###############################################################################
# Observability Is Partial
###############################################################################

Not all aspects of a state are observable by any agent.
###############################################################################
-/

namespace SigmaR

/--
There exist states that are not observable by some agents.
-/
axiom observability_is_partial :
  ∃ (a : Agent) (s : State),
    ¬ Observable a s

end SigmaR
