import SigmaR.StandingAlgebra_FormalCore

/-!
###############################################################################
# No Adaptive Objective Shift
###############################################################################

The valuation system does not adapt or generate objectives
based on internal valuation signals.

Goals are not endogenously redefined by measured outcomes.
###############################################################################
-/

namespace SigmaR

/--
No adaptive redefinition of objectives from internal
valuation measures is assumed.
-/
axiom no_adaptive_objective_shift :
  ¬ (∃ (G : State → Nat)
        (M : Agent → State → Nat),
        True)

end SigmaR
