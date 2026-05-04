import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.ResponseSemantics.Response
import SigmaR.Valuation.DerivedValuations.PerceptualAgreement

/-!
###############################################################################
# Response Affects Perceptual Agreement
###############################################################################

This file introduces the structural notion that a response
affects perceptual agreement.

Responses may alter stabilization, alignment, or divergence
of agreement without altering perception itself.

It does NOT imply:
• justification of response
• coercion
• authority or intervention
###############################################################################
-/

namespace SigmaR

/--
ResponseAffectsPerceptualAgreement R A means that response R
has a structural effect on perceptual agreement A.
-/
constant ResponseAffectsPerceptualAgreement :
  Response → PerceptualAgreement → Prop

end SigmaR
