import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.DerivedValuations.PerceptionValuation

/-!
###############################################################################
# Perception Depends On Measure
###############################################################################

This file introduces structural dependency of perception
valuation on underlying valuation measures.

Dependency does NOT imply:
• prioritization
• aggregation semantics
• normative importance

It is declarative only.
###############################################################################
-/

namespace SigmaR

/--
PerceptionDependsOnMeasure P M means that perception valuation P
structurally depends on valuation measure M.
-/
constant PerceptionDependsOnMeasure :
  PerceptionValuation → Measure → Prop

end SigmaR
