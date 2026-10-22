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

namespace SigmaR.Valuation.Measures.Monotonicity

/--
A valuation measure is treated as admitting projection
or restriction without reversing its structural monotonicity.
-/
axiom ProjectionPreservesMonotonicity :
  Measure → Prop

end SigmaR.Valuation.Measures.Monotonicity
