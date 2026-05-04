import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.ResponseSemantics.Response
import SigmaR.Valuation.DerivedValuations.RiskValuation.RiskAgreement

/-!
###############################################################################
# Response Affects Risk Agreement
###############################################################################

This file introduces the structural notion that a response
affects risk agreement.

Responses may alter stabilization or divergence of
risk agreement without redefining risk itself.

It does NOT:
• justify response
• authorize intervention
• imply probability belief
###############################################################################
-/

namespace SigmaR

/--
ResponseAffectsRiskAgreement R A means that response R
has a structural effect on risk agreement A.
-/
constant ResponseAffectsRiskAgreement :
  Response → RiskAgreement → Prop

end SigmaR
