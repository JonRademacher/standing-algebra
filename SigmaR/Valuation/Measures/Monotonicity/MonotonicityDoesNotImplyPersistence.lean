import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Measures.Monotonicity.MonotonicityScope

/-!
###############################################################################
# Monotonicity Does Not Imply Persistence (Contract)
###############################################################################

Monotonicity of a valuation measure must not be interpreted
as guaranteeing persistence of values across state progression.

This file introduces no axioms.
It names an interpretive boundary governing the use of
monotonicity within SigmaR.
###############################################################################
-/

namespace SigmaR

/--
Monotonicity relations are treated as non-persistent.
-/
constant MonotonicityDoesNotGuaranteePersistence : Prop

end SigmaR
