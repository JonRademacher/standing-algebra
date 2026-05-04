import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.DerivedValuations.RiskValuation.RiskValuation

/-!
###############################################################################
# Risk Irreversibility
###############################################################################

This file introduces irreversibility in risk valuation.

Irreversibility captures cases where accumulated or
inherited risk cannot be undone within the current
structural regime.

It does NOT:
• imply permanence in principle
• assign blame
• authorize intervention
###############################################################################
-/

namespace SigmaR

/--
RiskIrreversibility R means that risk valuation R
is structurally irreversible once accumulated.
-/
constant RiskIrreversibility :
  RiskValuation → Prop

end SigmaR
