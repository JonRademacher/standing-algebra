import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.DerivedValuations.RiskValuation.RiskValuation
import SigmaR.Valuation.DerivedValuations.CouplingValuation.CouplingValuation

/-!
###############################################################################
# Risk Depends On Coupling
###############################################################################

This file introduces structural dependency of risk
valuation on coupling relationships.

This captures that risk may be inherited, amplified,
or transferred via relational structure.

It does NOT:
• imply fault
• assign blame
• assert domination
###############################################################################
-/

namespace SigmaR

/--
RiskDependsOnCoupling R C means that risk valuation R
is structurally grounded in coupling valuation C.
-/
constant RiskDependsOnCoupling :
  RiskValuation → CouplingValuation → Prop

end SigmaR
