import SigmaR.StandingAlgebra_FormalCore

/-!
###############################################################################
# No Endogenous Goal Formation
###############################################################################

The valuation system does not generate its own goals
from internal measures or dynamics.
###############################################################################
-/

namespace SigmaR

/--
No endogenous goal formation is assumed.
-/
axiom no_endogenous_goal_formation :
  ¬ (∃ (G : State → Nat),
        True)

end SigmaR
