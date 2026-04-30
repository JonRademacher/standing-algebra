import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Measures.AutonomyMeasure_Definition
import SigmaR.Valuation.Measures.Monotonicity.MeasureStructuralMonotonicity

/-!
###############################################################################
# Autonomy Not Created Ex Nihilo (Structural)
###############################################################################

Autonomy is not treated as spontaneously increasing
along the state preorder without enabling structure.

This file names the structural monotonicity constraint.
It does not assert it as a global semantic law.
###############################################################################
-/

namespace SigmaR

/--
Autonomy is treated as requiring enabling structure
to increase along the state preorder.
-/
constant AutonomyRequiresEnablingStructure :
  Agent → Prop

end SigmaR
