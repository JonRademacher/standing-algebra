import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Core.StructuralInterfaces

/-!
###############################################################################
# Well-Formed Agent–State Arity
###############################################################################

Valuation measures must *genuinely* depend on both Agent and State.

This file prevents arity collapse, currying abuse, and the use of
agent-free or state-free functions as valuation measures.
###############################################################################
-/

namespace SigmaR

/--
No function that ignores the Agent dimension may be treated
as a valuation measure.
-/
axiom no_agent_free_measure :
  ¬ (
    ∀ (f : State → Nat),
      IsMeasure (fun (_ : Agent) (s : State) => f s)
  )

/--
No function that ignores the State dimension may be treated
as a valuation measure.
-/
axiom no_state_free_measure :
  ¬ (
    ∀ (f : Agent → Nat),
      IsMeasure (fun (a : Agent) (_ : State) => f a)
  )

end SigmaR
