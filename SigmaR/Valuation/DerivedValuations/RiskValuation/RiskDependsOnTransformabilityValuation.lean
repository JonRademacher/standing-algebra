import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.DerivedValuations.RiskValuation.RiskValuation
import SigmaR.Valuation.DerivedValuations.TransformabilityValuation.TransformabilityValuation

/-!
###############################################################################
# Risk Depends On Transformability Valuation
###############################################################################

This file introduces structural dependency of risk
valuation on transformability valuation.

This captures that inability to alter constraints
can increase structural exposure.

It does NOT:
• imply fault
• imply failure
• assert responsibility
###############################################################################
-/

namespace SigmaR

/--
RiskDependsOnTransformabilityValuation R T means that
risk valuation R is structurally dependent on
transformability valuation T.
-/
constant RiskDependsOnTransformabilityValuation :
  RiskValuation → TransformabilityValuation → Prop

end SigmaR
