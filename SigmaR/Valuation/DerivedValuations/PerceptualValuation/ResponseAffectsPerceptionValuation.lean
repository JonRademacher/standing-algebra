import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.ResponseSemantics.Response
import SigmaR.Valuation.DerivedValuations.PerceptionValuation

/-!
###############################################################################
# Response Affects Perception Valuation
###############################################################################

This file introduces the structural notion that a response
affects perception valuation.

This captures downstream effects on valuation resulting
from changes to perceptual agreement.

It does NOT imply:
• legitimacy of response
• authority
• intervention
###############################################################################
-/

namespace SigmaR

/--
ResponseAffectsPerceptionValuation R P means that response R
has a structural effect on perception valuation P.
-/
constant ResponseAffectsPerceptionValuation :
  Response → PerceptionValuation → Prop

end SigmaR
