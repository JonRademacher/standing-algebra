import SigmaR.StandingAlgebra_FormalCore

/-!
###############################################################################
# No Equilibrium Assumption
###############################################################################

The valuation system does not assume the existence
of equilibria or steady states.
###############################################################################
-/

namespace SigmaR

/--
No equilibrium state is assumed to exist.
-/
axiom no_equilibrium_assumption :
  ¬ (∃ (s : State),
        ∀ (a : Agent),
          True)

end SigmaR
