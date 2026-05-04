import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.DerivedValuations.PerceptualAgreement

/-!
###############################################################################
# Agreement Misalignment
###############################################################################

This file introduces misalignment between internalized
and externalized perceptual agreements.

Misalignment captures divergence between personal warrant
(iPFA) and plural agreement (PFA) without invalidating either.

It does NOT:
• assign error
• privilege consensus
• justify coercion
###############################################################################
-/

namespace SigmaR

/--
AgreementMisalignment Aᵢ Aₑ means that internal perceptual
agreement Aᵢ and external perceptual agreement Aₑ
are structurally misaligned.
-/
constant AgreementMisalignment :
  PerceptualAgreement → PerceptualAgreement → Prop

end SigmaR
