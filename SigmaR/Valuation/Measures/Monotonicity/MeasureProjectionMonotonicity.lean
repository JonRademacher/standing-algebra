import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Measures.Monotonicity.MeasureStructuralMonotonicity

/-!
###############################################################################
# Measure Projection Monotonicity (Structural)
###############################################################################

Projection or restriction of valuation measures may be treated
as preserving monotonicity in certain models or interpretive regimes.

This file names the admissibility of monotonicity-preserving
projection and restriction.
It does not assert it as a global semantic law.
###############################################################################
-/

namespace SigmaR

/--
A valuation measure is treated as admitting projection
or restriction without reversing its structural monotonicity.
-/
constant ProjectionPreservesMonotonicity :
  Measure → Prop

end SigmaR
