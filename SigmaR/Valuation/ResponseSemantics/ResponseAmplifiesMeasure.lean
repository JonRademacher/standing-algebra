import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.ResponseSemantics.Response

/-!
###############################################################################
# Response Amplifies Measure
###############################################################################

This file introduces the notion that a response increases
a valuation measure.

Amplification does NOT imply:
• benefit
• desirability
• correctness
• optimization

It is directional structure only.
###############################################################################
-/

namespace SigmaR

/--
ResponseAmplifiesMeasure R M means that response R
increases valuation measure M.
-/
constant ResponseAmplifiesMeasure :
  Response → Measure → Prop

end SigmaR
