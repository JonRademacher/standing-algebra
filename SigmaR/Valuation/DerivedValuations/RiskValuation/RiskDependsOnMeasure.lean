import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.DerivedValuations.RiskValuation.RiskValuation

/-!
###############################################################################
# Risk Depends On Measure
###############################################################################

This file introduces structural dependency of risk
valuation on underlying valuation measures.

Dependency does NOT imply:
• culpability
• prioritization
• normative assessment

It is declarative only.
###############################################################################
-/

namespace SigmaR

/--
RiskDependsOnMeasure R M means that risk valuation R
structurally depends on valuation measure M.
-/
constant RiskDependsOnMeasure :
  RiskValuation → Measure → Prop

end SigmaR
