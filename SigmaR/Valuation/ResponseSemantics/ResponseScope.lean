import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.ResponseSemantics.Response

/-!
###############################################################################
# Response Scope
###############################################################################

Response semantics are always relative to an explicitly
declared scope or context.

They must never be assumed to apply globally.
###############################################################################
-/

namespace SigmaR

/--
Response semantics are explicitly scoped
and never globally applicable by default.
-/
constant ResponseScope : Prop

end SigmaR
