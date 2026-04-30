import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.ResponseSemantics.Response

/-!
###############################################################################
# Response Postcondition
###############################################################################

This file defines structural postconditions of responses.

Postconditions describe resulting states without implying
desirability, success, or improvement.
###############################################################################
-/

namespace SigmaR

/--
A structural postcondition describing the result
of a response.
-/
constant ResponsePostcondition :
  Response → State → Prop

end SigmaR
