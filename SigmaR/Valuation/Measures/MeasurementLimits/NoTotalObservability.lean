import SigmaR.StandingAlgebra_FormalCore

/-!
###############################################################################
# No Total Observability
###############################################################################

There is no agent for whom the entire system state
is fully observable.
###############################################################################
-/

namespace SigmaR

/--
No agent has total observability of all states.
-/
axiom no_total_observability :
  ¬ (∃ (a : Agent),
        ∀ (s : State),
          True)

end SigmaR
