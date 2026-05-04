import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.DerivedValuations.RiskValuation.RiskValuation

/-!
###############################################################################
# Risk Load
###############################################################################

This file introduces load in risk valuation.

Risk load represents the amount of accumulated structural
risk borne by an agent or system.

It does NOT:
• imply blame
• imply obligation to act
• justify intervention
###############################################################################
-/

namespace SigmaR

/--
RiskLoad R means that risk valuation R
carries accumulated structural load.
-/
constant RiskLoad :
  RiskValuation → Prop

end SigmaR
