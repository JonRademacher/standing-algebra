import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Core.StructuralInterfaces

/-!
###############################################################################
# Observability Is Local
###############################################################################

Observability of the system state is local to an agent.
There is no global perspective that reveals all information.
###############################################################################
-/

namespace SigmaR.Valuation.Measures.Relevance

open SigmaR.Valuation.Core

/--
No implication asserting a globally uniform or
agent-independent observability predicate is permitted.
-/
axiom observability_is_local :
  ¬ (
    ∃ (O : State → Prop),
      ∀ (a : Agent) (s : State),
        Observable a s ↔ O s
  )

end SigmaR.Valuation.Measures.Relevance
