import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.DerivedValuations.CapacityValuation

/-!
###############################################################################
# Capacity Depends On Measure
###############################################################################

This file introduces structural dependency of capacity
valuation on underlying valuation measures.

Dependency does NOT imply:
• prioritization
• optimization
• merit or competence judgment

It is declarative only.
###############################################################################
-/

namespace SigmaR

/--
CapacityDependsOnMeasure C M means that capacity valuation C
structurally depends on valuation measure M.
-/
constant CapacityDependsOnMeasure :
  CapacityValuation → Measure → Prop

end SigmaR
