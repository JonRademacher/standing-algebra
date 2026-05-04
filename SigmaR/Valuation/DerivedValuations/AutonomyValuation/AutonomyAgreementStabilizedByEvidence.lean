import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.DerivedValuations.AutonomyValuation.AutonomyAgreement

/-!
###############################################################################
# Autonomy Agreement Stabilized By Evidence
###############################################################################

This file introduces non-parochial evidence as a stabilizer
of autonomy agreement.

Evidence stabilizes agreement without asserting consent,
authority, or legitimacy.

It does NOT:
• mandate action
• justify intervention
• imply moral judgment
###############################################################################
-/

namespace SigmaR

/--
AutonomyAgreementStabilizedByEvidence A means that autonomy
agreement A is stabilized through non-parochial evidence.
-/
constant AutonomyAgreementStabilizedByEvidence :
  AutonomyAgreement → Prop

end SigmaR
