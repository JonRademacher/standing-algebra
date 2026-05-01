import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.ResponseSemantics.Response

/-!
###############################################################################
# Response Affects Measure
###############################################################################

This file introduces the structural notion that a response
has some effect on a valuation measure.

It does NOT:
• specify the direction of the effect
• imply improvement or degradation
• imply desirability or harm
• imply intervention or authority

It is purely descriptive.
###############################################################################
-/

namespace SigmaR

/--
ResponseAffectsMeasure R M means that response R
has a structural effect on valuation measure M.
-/
constant ResponseAffectsMeasure :
  Response → Measure → Prop

end SigmaR
