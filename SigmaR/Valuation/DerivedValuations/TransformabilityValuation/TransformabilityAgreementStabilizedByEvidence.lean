import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.DerivedValuations.TransformabilityValuation.TransformabilityAgreement

/-!
###############################################################################
# Transformability Agreement Stabilized By Evidence
###############################################################################

This file introduces non-parochial evidence as a stabilizer
of transformability agreement.

Evidence stabilizes agreement without asserting authority,
merit, or selection.

It does NOT:
• mandate outcomes
• authorize intervention
• imply optimization
###############################################################################
-/

namespace SigmaR

/--
TransformabilityAgreementStabilizedByEvidence A means that
transformability agreement A is stabilized through
non-parochial evidence.
-/
constant TransformabilityAgreementStabilizedByEvidence :
  TransformabilityAgreement → Prop

end SigmaR
