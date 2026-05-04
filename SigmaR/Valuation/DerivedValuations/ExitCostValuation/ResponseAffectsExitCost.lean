import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.ResponseSemantics.Response
import SigmaR.Valuation.DerivedValuations.ExitCostValuation

/-!
###############################################################################
# Response Affects Exit Cost
###############################################################################

This file introduces the structural notion that a response
affects exit cost valuation.

This does NOT imply:
• justification for response
• restriction of exit
• authority or intervention

It is descriptive only.
###############################################################################
-/

namespace SigmaR

/--
ResponseAffectsExitCost R E means that response R
has a structural effect on exit cost valuation E.
-/
constant ResponseAffectsExitCost :
  Response → ExitCostValuation → Prop

end SigmaR
