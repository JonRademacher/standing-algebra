import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Measures.ExitViability_Definition
import SigmaR.Valuation.Measures.Monotonicity.MeasureStructuralMonotonicity

/-!
###############################################################################
# Exit Viability Not Created Ex Nihilo (Structural)
###############################################################################

Exit viability is treated as not spontaneously increasing
along the state preorder without enabling structural conditions.

This file names the monotonicity constraint.
It does not assert it as a global semantic law.
###############################################################################
-/

namespace SigmaR

/--
Exit viability is treated as requiring enabling structure
to arise along the state preorder.
-/
constant ExitViabilityRequiresEnablingStructure :
  Agent → Prop

end SigmaR
