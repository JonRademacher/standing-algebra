import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Measures.Monotonicity.MonotonicityScope

/-!
###############################################################################
# Monotonicity Non-Totality (Contract)
###############################################################################

The state ordering used for monotonicity is not required
to be total.

Monotonicity may be defined over partial orders,
preorders, or other non-total structures.

This file introduces no axioms.
It names an interpretive boundary governing the use
of state orderings within SigmaR.
###############################################################################
-/

namespace SigmaR

/--
The state ordering used for monotonicity is treated
as potentially non-total.
-/
constant MonotonicityAllowsNonTotalOrder : Prop

end SigmaR
