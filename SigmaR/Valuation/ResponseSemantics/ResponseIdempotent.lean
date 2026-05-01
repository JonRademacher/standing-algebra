import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.ResponseSemantics.Response

/-!
###############################################################################
# Response Idempotent
###############################################################################

This file introduces the structural notion of idempotence.

Idempotence means that repeated application does not
compound effects.

It does NOT imply:
• stability guarantees
• safety
• correctness
###############################################################################
-/

namespace SigmaR

/--
ResponseIdempotent R means that repeated application
of response R does not accumulate additional effect.
-/
constant ResponseIdempotent :
  Response → Prop

end SigmaR
