import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.DerivedValuations.RiskValuation.RiskValuation

/-!
###############################################################################
# Risk Threshold
###############################################################################

This file introduces thresholds in risk valuation.

Thresholds represent structural demarcations where
risk behavior changes qualitatively.

They do NOT:
• mandate action
• imply collapse by default
• assert normative evaluation
###############################################################################
-/

namespace SigmaR

/--
RiskThreshold R means that risk valuation R
is associated with a structural threshold.
-/
constant RiskThreshold :
  RiskValuation → Prop

end SigmaR
