import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.DerivedValuations.RiskValuation.RiskValuation

/-!
###############################################################################
# Risk Hysteresis
###############################################################################

This file introduces hysteresis in risk valuation.

Hysteresis captures path dependence: current risk exposure
depends on prior states, not just present conditions.

It does NOT:
• imply misjudgment
• imply fault
• assert moral failure
###############################################################################
-/

namespace SigmaR

/--
RiskHysteresis R means that risk valuation R
exhibits path-dependent behavior.
-/
constant RiskHysteresis :
  RiskValuation → Prop

end SigmaR
