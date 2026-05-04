import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.DerivedValuations.RiskValuation.RiskValuation
import SigmaR.Valuation.DerivedValuations.CapacityValuation.CapacityValuation

/-!
###############################################################################
# Risk Depends On Capacity Valuation
###############################################################################

This file introduces structural dependency of risk
valuation on capacity valuation.

This captures that limited effective capacity may
increase exposure to structural risk.

It does NOT:
• imply incompetence
• imply blame
• assert causation
###############################################################################
-/

namespace SigmaR

/--
RiskDependsOnCapacityValuation R C means that risk valuation R
is structurally dependent on capacity valuation C.
-/
constant RiskDependsOnCapacityValuation :
  RiskValuation → CapacityValuation → Prop

end SigmaR
