import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.ResponseSemantics.Response

/-!
###############################################################################
# Response Precondition
###############################################################################

This file defines structural preconditions for responses.

A precondition specifies when a response is applicable,
without asserting that it should be applied.
###############################################################################
-/

namespace SigmaR.Valuation.ResponseSemantics

/--
A structural precondition under which a response may apply.
-/
axiom ResponsePrecondition :
  Response → State → Prop

end SigmaR.Valuation.ResponseSemantics
