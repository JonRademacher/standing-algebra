import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.DerivedValuations.AutonomyValuation.AutonomyValuation

/-!
###############################################################################
# Autonomy Depends On Measure
###############################################################################

This file introduces the structural dependency of autonomy
valuation on underlying valuation measures.

Dependency does NOT imply:
• prioritization
• aggregation semantics
• normative importance

It is a declarative dependency only.
###############################################################################
-/

namespace SigmaR

/--
AutonomyDependsOnMeasure A M means that autonomy valuation A
structurally depends on valuation measure M.
-/
constant AutonomyDependsOnMeasure :
  AutonomyValuation → Measure → Prop

end SigmaR
