import SigmaR.StandingAlgebra_FormalCore

/-!
###############################################################################
# No Fixed Point Assumption
###############################################################################

The valuation system does not assume the existence
of fixed points under state progression or valuation.
###############################################################################
-/

namespace SigmaR

/--
No valuation fixed point is assumed.
-/
axiom no_fixed_point_assumption :
  ¬ (∃ (s : State),
        ∀ (a : Agent),
          True)

end SigmaR
