import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.DerivedValuations.RiskValuation.RiskValuation

/-!
###############################################################################
# Risk Collapse
###############################################################################

This file introduces collapse in risk valuation.

Collapse represents a regime where structural risk
exceeds viability limits under current conditions.

It does NOT:
• imply fault
• imply culpability
• authorize intervention
###############################################################################
-/

namespace SigmaR

/--
RiskCollapse R means that risk valuation R
has structurally collapsed.
-/
constant RiskCollapse :
  RiskValuation → Prop

end SigmaR
