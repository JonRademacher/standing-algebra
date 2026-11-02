import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.DerivedValuations.CapacityValuation.CapacityValuation

/-!
###############################################################################
# Capacity Depends On Context
###############################################################################

This file introduces structural dependency of capacity
valuation on context.

Context includes situational, environmental, temporal,
and structural conditions.

Context dependence does NOT imply:
• subjectivity
• relativism
• authority
###############################################################################
-/

namespace SigmaR.Valuation.DerivedValuations.CapacityValuation

/--
CapacityDependsOnContext C means that capacity valuation C
is explicitly context-dependent.
-/
axiom CapacityDependsOnContext :
  CapacityValuation → Prop

end SigmaR.Valuation.DerivedValuations.CapacityValuation
