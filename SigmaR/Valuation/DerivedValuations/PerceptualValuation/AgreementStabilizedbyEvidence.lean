import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.DerivedValuations.PerceptualAgreement

/-!
###############################################################################
# Agreement Stabilized By Evidence
###############################################################################

This file introduces non-parochial evidence as a stabilizer
of perceptual agreement.

Evidence stabilizes agreement without asserting authority,
truth, or moral priority.

It does NOT:
• override perception
• invalidate personal warrant
• imply coercion
###############################################################################
-/

namespace SigmaR

/--
AgreementStabilizedByEvidence A means that perceptual agreement A
is stabilized through non-parochial evidence.
-/
constant AgreementStabilizedByEvidence :
  PerceptualAgreement → Prop

end SigmaR
