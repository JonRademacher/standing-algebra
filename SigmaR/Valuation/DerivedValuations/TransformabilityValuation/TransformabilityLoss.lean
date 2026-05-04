import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.DerivedValuations.TransformabilityValuation.TransformabilityValuation

/-!
###############################################################################
# Transformability Loss
###############################################################################

This file introduces the structural notion of loss
in transformability valuation.

Transformability loss represents a reduction in effective
ability to transform state under structural conditions.

It does NOT:
• imply fault
• imply incompetence
• imply error or blame
###############################################################################
-/

namespace SigmaR

/--
TransformabilityLoss T₁ T₂ means that transformability valuation T₂
represents a loss relative to transformability valuation T₁.
-/
constant TransformabilityLoss :
  TransformabilityValuation → TransformabilityValuation → Prop

end SigmaR
