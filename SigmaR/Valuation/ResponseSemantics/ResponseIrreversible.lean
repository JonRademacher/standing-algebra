import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.ResponseSemantics.Response

/-!
###############################################################################
# Response Irreversible
###############################################################################

This file introduces the structural notion of response irreversibility.

Irreversibility does NOT imply:
• harm
• finality
• moral weight
• obligation

It only characterizes non-reversibility.
###############################################################################
-/

namespace SigmaR

/--
ResponseIrreversible R means that response R
does not admit a structural reversal.
-/
constant ResponseIrreversible :
  Response → Prop

end SigmaR
