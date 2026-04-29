import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Core.StructuralInterfaces

/-!
###############################################################################
# No Total Observability
###############################################################################

There is no agent for whom the entire system state
is fully observable.

No observer has complete access to all states.
###############################################################################
-/

namespace SigmaR

/--
No agent is assumed to observe all states.
-/
axiom no_total_observability :
  ¬ (
    ∃ (a : Agent),
      ∀ (s : State),
        Observable a s
  )

end SigmaR
