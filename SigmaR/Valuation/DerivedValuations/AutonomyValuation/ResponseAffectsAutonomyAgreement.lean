import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.ResponseSemantics.Response
import SigmaR.Valuation.DerivedValuations.AutonomyValuation.AutonomyAgreement

/-!
###############################################################################
# Response Affects Autonomy Agreement
###############################################################################

This file introduces the structural notion that a response
affects autonomy agreement.

Responses may alter stabilization, recognition, or divergence
of autonomy agreement without redefining autonomy itself.

It does NOT:
• justify the response
• imply consent
• authorize intervention
###############################################################################
-/

namespace SigmaR

/--
ResponseAffectsAutonomyAgreement R A means that response R
has a structural effect on autonomy agreement A.
-/
constant ResponseAffectsAutonomyAgreement :
  Response → AutonomyAgreement → Prop

end SigmaR
