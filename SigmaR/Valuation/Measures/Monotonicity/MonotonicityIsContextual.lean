import SigmaR.StandingAlgebra_FormalCore

/-!
###############################################################################
# Monotonicity Is Contextual (Contract)
###############################################################################

Monotonicity applies only within an explicit state ordering
and an explicit interpretive or system context.

This file introduces no axioms.
It names an interpretive boundary governing the use of
monotonicity within SigmaR.
###############################################################################
-/

namespace SigmaR

/--
Monotonicity relations are treated as context-dependent.
-/
constant MonotonicityIsContextual : Prop

end SigmaR
