import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.ResponseSemantics.Response
import SigmaR.Valuation.DerivedValuations.StandingValuation

/-!
###############################################################################
# Response Affects Standing
###############################################################################

This file introduces the structural notion that a response
affects standing valuation.

This does NOT imply:
• justification for response
• mitigation or repair
• authority or intervention

It is descriptive only.
###############################################################################
-/

namespace SigmaR

/--
ResponseAffectsStanding R S means that response R
has a structural effect on standing valuation S.
-/
constant ResponseAffectsStanding :
  Response → StandingValuation → Prop

end SigmaR
