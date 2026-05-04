import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.DerivedValuations.TransformabilityValuation.TransformabilityAgreement

/-!
###############################################################################
# External Transformability Agreement
###############################################################################

This file introduces externalized transformability agreement.

External agreement represents stabilized plural assessment
of transformability across agents.

It does NOT:
• override internal agreement
• imply authority or entitlement
• assert correctness
###############################################################################
-/

namespace SigmaR

/--
ExternalTransformabilityAgreement A means that transformability
agreement A is externalized across multiple agents.
-/
constant ExternalTransformabilityAgreement :
  TransformabilityAgreement → Prop

end SigmaR
