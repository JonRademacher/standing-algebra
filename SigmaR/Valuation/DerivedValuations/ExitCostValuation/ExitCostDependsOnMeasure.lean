import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.DerivedValuations.ExitCostValuation.ExitCostValuation

/-!
###############################################################################
# Exit Cost Depends On Measure
###############################################################################

This file introduces structural dependency of exit cost valuation
on underlying valuation measures.

Dependency does NOT imply:
• prioritization
• aggregation semantics
• normative importance

It is declarative only.
###############################################################################
-/

namespace SigmaR.Valuation.DerivedValuations.ExitCostValuation

/--
ExitCostDependsOnMeasure E M means that exit cost valuation E
structurally depends on valuation measure M.
-/
axiom ExitCostDependsOnMeasure :
  ExitCostValuation → Measure → Prop

end SigmaR.Valuation.DerivedValuations.ExitCostValuation
