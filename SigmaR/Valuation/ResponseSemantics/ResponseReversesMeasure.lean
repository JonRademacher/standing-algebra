import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.ResponseSemantics.Response

/-!
###############################################################################
# Response Reverses Measure
###############################################################################

This file introduces the notion that a response reverses
the direction or effect of a valuation measure.

Reversal does NOT imply:
• repair
• restoration
• correction
• legitimacy

It is a structural inversion only.
###############################################################################
-/

namespace SigmaR

/--
ResponseReversesMeasure R M means that response R
structurally reverses the effect or direction
of valuation measure M.
-/
constant ResponseReversesMeasure :
  Response → Measure → Prop

end SigmaR
