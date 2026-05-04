import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.ResponseSemantics.Response
import SigmaR.Valuation.DerivedValuations.RiskValuation.RiskValuation

/-!
###############################################################################
# Response Affects Risk Valuation
###############################################################################

This file introduces the structural notion that a response
affects risk valuation.

This captures downstream effects on effective risk exposure
resulting from changes to agreement, exposure, or propagation.

It does NOT:
• authorize action
• imply blame
• assert legitimacy
###############################################################################
-/

namespace SigmaR

/--
ResponseAffectsRiskValuation R V means that response R
has a structural effect on risk valuation V.
-/
constant ResponseAffectsRiskValuation :
  Response → RiskValuation → Prop

end SigmaR
