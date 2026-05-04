import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.DerivedValuations.TransformabilityValuation.TransformabilityValuation
import SigmaR.Valuation.DerivedValuations.CapacityValuation.CapacityValuation

/-!
###############################################################################
# Transformability Depends On Capacity Valuation
###############################################################################

This file introduces structural dependency of transformability
valuation on capacity valuation.

This captures that the ability to perform transformations
is bounded by effective, usable capacity.

It does NOT:
• equate capacity with transformability
• imply competence or merit
###############################################################################
-/

namespace SigmaR

/--
TransformabilityDependsOnCapacityValuation T C means that
transformability valuation T is structurally dependent
on capacity valuation C.
-/
constant TransformabilityDependsOnCapacityValuation :
  TransformabilityValuation → CapacityValuation → Prop

end SigmaR
