import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Measures.CapacityMeasure_Definition
import SigmaR.Valuation.Measures.Monotonicity.MeasureStructuralMonotonicity

/-!
###############################################################################
# Capacity Is Upper Bounded (Structural)
###############################################################################

Capacity is treated as having a finite upper bound
within certain models or interpretive regimes.

This file names the boundedness constraint.
It does not assert it globally.
###############################################################################
-/

namespace SigmaR

/--
Capacity is treated as upper bounded.
-/
constant CapacityUpperBounded : Prop

end SigmaR
