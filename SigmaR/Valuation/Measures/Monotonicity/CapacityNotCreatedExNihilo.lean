import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Measures.CapacityMeasure_Definition
import SigmaR.Valuation.Measures.Monotonicity.MeasureStructuralMonotonicity

/-!
###############################################################################
# Capacity Not Created Ex Nihilo (Structural)
###############################################################################

Capacity is treated as not spontaneously increasing
along the state preorder without enabling structure.

This file names the monotonicity constraint.
It does not assert it as a global semantic law.
###############################################################################
-/

namespace SigmaR

/--
Capacity is treated as requiring enabling structure
to increase along the state preorder.
-/
constant CapacityRequiresEnablingStructure :
  Agent → Prop

end SigmaR
