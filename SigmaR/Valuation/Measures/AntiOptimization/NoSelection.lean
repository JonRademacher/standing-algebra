import SigmaR.StandingAlgebra_FormalCore

/-!
###############################################################################
# No Selection
###############################################################################

The valuation system does not assume selection,
fitness, or survival-based dynamics.
###############################################################################
-/

namespace SigmaR

/--
No selection principle is assumed.
-/
axiom no_selection :
  ¬ (∃ (select : State → State),
        True)

end SigmaR
