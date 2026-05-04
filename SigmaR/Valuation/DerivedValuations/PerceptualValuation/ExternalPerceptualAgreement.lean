import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.DerivedValuations.PerceptualAgreement

/-!
###############################################################################
# External Perceptual Agreement (PFA)
###############################################################################

This file introduces externalized perceptual frame agreement.

External agreement represents stabilization across agents
over shared perceptual content.

It does NOT redefine perception and does NOT override
internal perceptual agreement.
###############################################################################
-/

namespace SigmaR

/--
ExternalPerceptualAgreement A means that perceptual agreement A
is externalized across multiple agents.
-/
constant ExternalPerceptualAgreement :
  PerceptualAgreement → Prop

end SigmaR
