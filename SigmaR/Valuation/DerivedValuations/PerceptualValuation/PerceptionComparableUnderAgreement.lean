import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.DerivedValuations.PerceptionValuation
import SigmaR.Valuation.DerivedValuations.PerceptualAgreement

/-!
###############################################################################
# Perception Comparable Under Agreement
###############################################################################

This file introduces comparability of perception valuations
relative to a specific perceptual agreement.

This captures the fact that some comparisons are only
meaningful when conditioned on shared agreement context.

It does NOT:
• privilege consensus
• invalidate personal warrant
• assert correctness
###############################################################################
-/

namespace SigmaR

/--
PerceptionComparableUnderAgreement P₁ P₂ A means that
perception valuations P₁ and P₂ are structurally comparable
under perceptual agreement A.
-/
constant PerceptionComparableUnderAgreement :
  PerceptionValuation → PerceptionValuation → PerceptualAgreement → Prop

end SigmaR
