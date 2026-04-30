import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Measures.StandingMeasure_Definition
import SigmaR.Valuation.Measures.Monotonicity.MeasureStructuralMonotonicity

/-!
###############################################################################
# Standing Not Created Ex Nihilo (Structural)
###############################################################################

Standing is treated as not spontaneously increasing
along the state preorder without enabling structural conditions.

This file names the monotonicity constraint.
It does not assert it as a global semantic law.
###############################################################################
-/

namespace SigmaR

/--
Standing is treated as requiring enabling structure
to increase along the state preorder.
-/
constant StandingRequiresEnablingStructure :
  Agent → Prop

end SigmaR
