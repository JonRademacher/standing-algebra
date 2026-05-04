import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.DerivedValuations.ExitCostValuation

/-!
###############################################################################
# Exit Cost Loss
###############################################################################

This file introduces the structural notion of loss
for exit cost valuations.

Loss does NOT imply:
• wrongdoing
• legitimacy of coercion
• obligation to respond

It is a descriptive valuation change only.
###############################################################################
-/

namespace SigmaR

/--
ExitCostLoss E₁ E₂ means that exit cost valuation E₂
represents a loss relative to exit cost valuation E₁.
-/
constant ExitCostLoss :
  ExitCostValuation → ExitCostValuation → Prop

end SigmaR
