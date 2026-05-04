import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.DerivedValuations.RiskValuation.RiskValuation

/-!
###############################################################################
# Risk Loss
###############################################################################

This file introduces loss in risk valuation.

Risk loss represents reduction in structural risk exposure,
not elimination of hazard.

It does NOT:
• imply safety
• assert fault or responsibility
• justify complacency
###############################################################################
-/

namespace SigmaR

/--
RiskLoss R₁ R₂ means that risk valuation R₂
represents reduced risk relative to R₁.
-/
constant RiskLoss :
  RiskValuation → RiskValuation → Prop

end SigmaR
