import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.DerivedValuations.TransformabilityValuation.TransformabilityValuation
import SigmaR.Valuation.DerivedValuations.PerceptionValuation.PerceptionValuation

/-!
###############################################################################
# Transformability Depends On Perceptual Valuation
###############################################################################

This file introduces structural dependency of transformability
valuation on perceptual valuation.

This captures that the ability to identify, recognize,
and stabilize transformations depends on perceptual framing,
without collapsing perception into authority.

It does NOT:
• assert correctness
• imply preference
• justify selection
###############################################################################
-/

namespace SigmaR

/--
TransformabilityDependsOnPerceptualValuation T P means that
transformability valuation T is structurally dependent
on perceptual valuation P.
-/
constant TransformabilityDependsOnPerceptualValuation :
  TransformabilityValuation → PerceptionValuation → Prop

end SigmaR
