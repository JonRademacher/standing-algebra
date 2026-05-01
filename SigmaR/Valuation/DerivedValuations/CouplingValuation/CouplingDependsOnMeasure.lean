import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.DerivedValuations.CouplingValuation

/-!
###############################################################################
# Coupling Depends On Measure
###############################################################################

This file introduces structural dependency of coupling valuation
on underlying valuation measures.

Dependency does NOT imply:
• prioritization
• aggregation semantics
• normative importance

It is declarative only.
###############################################################################
-/

namespace SigmaR

/--
CouplingDependsOnMeasure C M means that coupling valuation C
structurally depends on valuation measure M.
-/
constant CouplingDependsOnMeasure :
  CouplingValuation → Measure → Prop

end SigmaR
