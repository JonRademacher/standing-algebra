import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.DerivedValuations.RiskValuation.RiskAgreement

/-!
###############################################################################
# Risk Agreement Stabilized By Evidence
###############################################################################

This file introduces non-parochial evidence as a stabilizer
of risk agreement.

Evidence stabilizes agreement without asserting fault,
culpability, or authority.

It does NOT:
• mandate mitigation
• authorize intervention
• imply probability belief
###############################################################################
-/

namespace SigmaR

/--
RiskAgreementStabilizedByEvidence A means that risk agreement A
is stabilized through non-parochial evidence.
-/
constant RiskAgreementStabilizedByEvidence :
  RiskAgreement → Prop

end SigmaR
