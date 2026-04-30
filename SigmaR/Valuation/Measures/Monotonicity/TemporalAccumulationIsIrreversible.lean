import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Measures.TemporalAccumulation_Definition
import SigmaR.Valuation.Measures.Monotonicity.MeasureStructuralMonotonicity

/-!
###############################################################################
# Temporal Accumulation Is Irreversible (Structural)
###############################################################################

Temporal accumulation is treated as non-decreasing
along the state preorder in the absence of
explicit repair or mitigation mechanisms.

This file names the irreversibility constraint.
It does not assert it as a global semantic law.
###############################################################################
-/

namespace SigmaR

/--
Temporal accumulation is treated as irreversible
along the state preorder.
-/
constant TemporalAccumulationIrreversible : Prop

end SigmaR
