import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.DerivedValuations.DerivedValuation

/-!
###############################################################################
# Valuation Loss
###############################################################################

This file introduces the structural notion of loss
for derived valuations.

Loss does NOT imply:
• harm
• wrongdoing
• justification for action
• moral judgment

It is a descriptive change in valuation only.
###############################################################################
-/

namespace SigmaR

/--
ValuationLoss V₁ V₂ means that valuation V₂
represents a loss relative to valuation V₁.
-/
constant ValuationLoss :
  DerivedValuation → DerivedValuation → Prop

end SigmaR
