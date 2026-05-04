import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.DerivedValuations.RiskValuation.RiskValuation

/-!
###############################################################################
# Risk Depends On Context
###############################################################################

This file introduces structural dependency of risk
valuation on context.

Context includes situational, environmental, temporal,
and structural conditions.

Context dependence does NOT imply:
• subjectivity
• relativism
• authority
###############################################################################
-/

namespace SigmaR

/--
RiskDependsOnContext R means that risk valuation R
is explicitly context-dependent.
-/
constant RiskDependsOnContext :
  RiskValuation → Prop

end SigmaR
