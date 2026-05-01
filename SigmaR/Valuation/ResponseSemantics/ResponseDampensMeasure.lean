import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.ResponseSemantics.Response

/-!
###############################################################################
# Response Dampens Measure
###############################################################################

This file introduces the notion that a response decreases
a valuation measure.

Dampening does NOT imply:
• harm
• mitigation
• improvement
• moral judgment

It is directional structure only.
###############################################################################
-/

namespace SigmaR

/--
ResponseDampensMeasure R M means that response R
decreases valuation measure M.
-/
constant ResponseDampensMeasure :
  Response → Measure → Prop

end SigmaR
