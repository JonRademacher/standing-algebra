import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.DerivedValuations.CapacityValuation.CapacityAgreement

/-!
###############################################################################
# Capacity Agreement Stabilized By Evidence
###############################################################################

This file introduces non-parochial evidence as a stabilizer
of capacity agreement.

Evidence stabilizes agreement without asserting authority,
merit, or moral judgment.

It does NOT:
• mandate outcomes
• authorize intervention
• imply selection
###############################################################################
-/

namespace SigmaR

/--
CapacityAgreementStabilizedByEvidence A means that capacity
agreement A is stabilized through non-parochial evidence.
-/
constant CapacityAgreementStabilizedByEvidence :
  CapacityAgreement → Prop

end SigmaR
