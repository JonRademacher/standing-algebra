import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.ResponseSemantics.Response

/-!
###############################################################################
# Response Reversible
###############################################################################

This file introduces the structural notion of response reversibility.

Reversibility does NOT imply:
• desirability
• repair
• restoration
• permission to reverse

It only characterizes structural possibility.
###############################################################################
-/

namespace SigmaR

/--
ResponseReversible R means that response R admits
a structural reversal.
-/
constant ResponseReversible :
  Response → Prop

end SigmaR
