import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.ResponseSemantics.Response
import SigmaR.Valuation.DerivedValuations.TransformabilityValuation.TransformabilityAgreement

/-!
###############################################################################
# Response Affects Transformability Agreement
###############################################################################

This file introduces the structural notion that a response
affects transformability agreement.

Responses may alter stabilization or divergence of
transformability agreement without redefining operations.

It does NOT:
• justify response
• authorize intervention
• imply selection
###############################################################################
-/

namespace SigmaR

/--
ResponseAffectsTransformabilityAgreement R A means that response R
has a structural effect on transformability agreement A.
-/
constant ResponseAffectsTransformabilityAgreement :
  Response → TransformabilityAgreement → Prop

end SigmaR
