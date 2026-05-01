import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.ResponseSemantics.Response
import SigmaR.Valuation.DerivedValuations.AutonomyValuation

/-!
###############################################################################
# Response Affects Autonomy
###############################################################################

This file introduces the structural notion that a response
affects autonomy valuation.

This does NOT imply:
• justification for response
• mitigation or repair
• authority or intervention

It is descriptive only.
###############################################################################
-/

namespace SigmaR

/--
ResponseAffectsAutonomy R A means that response R
has a structural effect on autonomy valuation A.
-/
constant ResponseAffectsAutonomy :
  Response → AutonomyValuation → Prop

end SigmaR
