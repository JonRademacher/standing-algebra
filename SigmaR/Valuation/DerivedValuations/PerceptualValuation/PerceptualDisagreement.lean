import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.DerivedValuations.PerceptualAgreement

/-!
###############################################################################
# Perceptual Disagreement
###############################################################################

This file introduces the structural notion of disagreement
between perceptual agreements.

Disagreement describes lack of alignment, not error.

It does NOT:
• privilege one agreement over another
• assert falsehood
• imply authority
###############################################################################
-/

namespace SigmaR

/--
PerceptualDisagreement A₁ A₂ means that perceptual agreements
A₁ and A₂ are not aligned.
-/
constant PerceptualDisagreement :
  PerceptualAgreement → PerceptualAgreement → Prop

end SigmaR
