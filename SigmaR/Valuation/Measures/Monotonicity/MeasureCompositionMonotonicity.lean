import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Measures.Monotonicity.MeasureStructuralMonotonicity

/-!
###############################################################################
# Measure Composition Monotonicity (Structural)
###############################################################################

Composition of valuation measures with monotone transformations
may be treated as preserving monotonicity in certain models
or interpretive regimes.

This file names the admissibility of such composition.
It does not assert it as a universal semantic law.
###############################################################################
-/

namespace SigmaR

/--
A valuation measure is treated as admitting monotone
post-composition without violating its structural monotonicity.
-/
constant MonotoneCompositionAdmissible :
  Measure → Prop

end SigmaR
