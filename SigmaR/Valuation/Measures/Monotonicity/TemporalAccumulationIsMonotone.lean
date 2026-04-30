import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Measures.TemporalAccumulation_Definition
import SigmaR.Valuation.Measures.Monotonicity.MeasureStructuralMonotonicity

/-!
###############################################################################
# Temporal Accumulation Is Monotone (Structural)
###############################################################################

Temporal accumulation is treated as non-decreasing
along the state preorder within certain models
or interpretive regimes.

This file names the monotonicity relationship.
It does not assert it as a global semantic law.
###############################################################################
-/

namespace SigmaR

/--
Temporal accumulation is treated as monotone
along the state preorder.
-/
constant TemporalAccumulationMonotone : Prop

end SigmaR
