import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.ResponseSemantics.Response

/-!
###############################################################################
# Response Respects Monotonicity
###############################################################################

This file introduces the constraint that a response
respects declared monotonicity conditions.

It does NOT:
• assert monotonicity
• assert irreversibility
• imply correctness
###############################################################################
-/

namespace SigmaR

/--
ResponseRespectsMonotonicity R means that response R
does not violate declared monotonicity constraints.
-/
constant ResponseRespectsMonotonicity :
  Response → Prop

end SigmaR
