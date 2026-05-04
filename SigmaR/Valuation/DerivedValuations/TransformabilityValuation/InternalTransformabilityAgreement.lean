import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.DerivedValuations.TransformabilityValuation.TransformabilityAgreement

/-!
###############################################################################
# Internal Transformability Agreement
###############################################################################

This file introduces internalized transformability agreement.

Internal agreement reflects an agent’s stabilized self-assessment
of their effective transformability, potentially accumulated
over time.

It grounds personal warrant and does NOT depend on
external validation.
###############################################################################
-/

namespace SigmaR

/--
InternalTransformabilityAgreement A means that transformability
agreement A is internalized within a single agent.
-/
constant InternalTransformabilityAgreement :
  TransformabilityAgreement → Prop

end SigmaR
