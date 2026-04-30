import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Measures.CapacityMeasure_Definition
import SigmaR.Valuation.Measures.StructuralDebt_Definition
import SigmaR.Valuation.Measures.Monotonicity.MeasureStructuralMonotonicity

/-!
###############################################################################
# Capacity Is Conditionally Monotone (Structural)
###############################################################################

Capacity is treated as conditionally non-increasing with respect
to structural debt along the state preorder.

This file *names* the monotonicity relationship.
It does not assert it as a global semantic law.
###############################################################################
-/

namespace SigmaR

/--
Capacity is treated as conditionally monotone decreasing
with respect to structural debt.
-/
constant CapacityConditionallyMonotoneUnderDebt :
  Agent → Prop

end SigmaR
