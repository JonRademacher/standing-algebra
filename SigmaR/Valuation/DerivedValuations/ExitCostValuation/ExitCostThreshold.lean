import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.DerivedValuations.ExitCostValuation

/-!
###############################################################################
# Exit Cost Threshold
###############################################################################

This file introduces the notion of thresholds
within exit cost valuation.

Thresholds do NOT imply:
• collapse
• intervention
• legitimacy
• moral judgment

They are structural demarcations only.
###############################################################################
-/

namespace SigmaR

/--
ExitCostThreshold E means that exit cost valuation E
is associated with a structural threshold.
-/
constant ExitCostThreshold :
  ExitCostValuation → Prop

end SigmaR
