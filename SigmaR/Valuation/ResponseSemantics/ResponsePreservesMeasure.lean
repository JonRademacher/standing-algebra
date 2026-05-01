import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.ResponseSemantics.Response

/-!
###############################################################################
# Response Preserves Measure
###############################################################################

This file introduces the notion that a response leaves
a valuation measure unchanged.

Preservation does NOT imply:
• desirability
• stability guarantees
• correctness
• protection

It is structural invariance only.
###############################################################################
-/

namespace SigmaR

/--
ResponsePreservesMeasure R M means that response R
does not alter valuation measure M.
-/
constant ResponsePreservesMeasure :
  Response → Measure → Prop

end SigmaR
