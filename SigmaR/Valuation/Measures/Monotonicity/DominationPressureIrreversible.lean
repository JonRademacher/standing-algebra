import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Measures.DominationPressure_Definition
import SigmaR.Valuation.Measures.Monotonicity.MeasureStructuralMonotonicity

/-!
###############################################################################
# Domination Pressure Is Irreversible (Structural)
###############################################################################

Domination pressure is treated as non-decreasing
along the state preorder within certain models
or interpretive regimes.

This file names the monotonicity constraint.
It does not assert it as a global semantic law.
###############################################################################
-/

namespace SigmaR

/--
Domination pressure is treated as irreversible
along the state preorder.
-/
constant DominationPressureIrreversible : Prop

end SigmaR
