import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.ResponseSemantics.Response

/-!
###############################################################################
# Response Composable
###############################################################################

This file introduces the notion that responses may be
composed sequentially without structural interference.

Composability does NOT imply:
• compatibility of goals
• authorization
• safety
###############################################################################
-/

namespace SigmaR

/--
ResponseComposable R₁ R₂ means that responses R₁ and R₂
may be structurally composed.
-/
constant ResponseComposable :
  Response → Response → Prop

end SigmaR
