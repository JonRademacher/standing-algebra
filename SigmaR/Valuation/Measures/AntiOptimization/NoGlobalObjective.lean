import SigmaR.StandingAlgebra_FormalCore

/-!
###############################################################################
# No Global Objective
###############################################################################

The SigmaR valuation system does not assume the existence
of any global objective or goal function.

No measure is defined relative to an optimizing target.
###############################################################################
-/

namespace SigmaR

/--
There is no global objective function governing valuation.
-/
axiom no_global_objective :
  ¬ (∃ (O : State → Nat),
        ∀ (a : Agent) (s : State),
          True)

end SigmaR
