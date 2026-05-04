import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.ResponseSemantics.Response
import SigmaR.Valuation.DerivedValuations.CapacityValuation.CapacityAgreement

/-!
###############################################################################
# Response Affects Capacity Agreement
###############################################################################

This file introduces the structural notion that a response
affects capacity agreement.

Responses may alter stabilization or divergence of
capacity agreement without redefining capacity itself.

It does NOT:
• justify response
• authorize intervention
• imply selection
###############################################################################
-/

namespace SigmaR

/--
ResponseAffectsCapacityAgreement R A means that response R
has a structural effect on capacity agreement A.
-/
constant ResponseAffectsCapacityAgreement :
  Response → CapacityAgreement → Prop

end SigmaR
