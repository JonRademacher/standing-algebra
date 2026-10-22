import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.DerivedValuations.PerceptualValuation.PerceptionValuation

/-!
###############################################################################
# Perception Loss
###############################################################################

This file introduces the structural notion of loss
for perception valuation.

Perception loss does NOT imply:
• error
• falsehood
• blame
• obligation to correct

It is a descriptive valuation change only.
###############################################################################
-/

namespace SigmaR.Valuation.DerivedValuations.PerceptualValuation

/--
PerceptionLoss P₁ P₂ means that perception valuation P₂
represents a loss relative to perception valuation P₁.
-/
axiom PerceptionLoss :
  PerceptionValuation → PerceptionValuation → Prop

end SigmaR.Valuation.DerivedValuations.PerceptualValuation
