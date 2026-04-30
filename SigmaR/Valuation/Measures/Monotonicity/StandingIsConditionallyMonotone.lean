import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Measures.StandingMeasure_Definition
import SigmaR.Valuation.Measures.DominationPressure_Definition
import SigmaR.Valuation.Measures.Monotonicity.MeasureStructuralMonotonicity

/-!
###############################################################################
# Standing Is Conditionally Monotone (Structural)
###############################################################################

Standing is treated as conditionally non-increasing
with respect to domination pressure along the state preorder.

This file names the conditional monotonicity relationship.
It does not assert it as a global semantic law.
###############################################################################
-/

namespace SigmaR

/--
Standing is treated as conditionally monotone decreasing
with respect to domination pressure.
-/
constant StandingConditionallyMonotoneUnderDomination :
  Agent → Prop

end SigmaR
