import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Measures.Definitions.StandingMeasure_Definition

/-!
###############################################################################
# Standing Is Upper Bounded (Structural)
###############################################################################

Standing is treated as having a finite upper bound
within certain models or interpretive regimes.

This file names the boundedness constraint.
It does not assert it as a global semantic law.
###############################################################################
-/

namespace SigmaR.Valuation.Measures.Monotonicity

/--
Standing is treated as upper bounded.
-/
axiom StandingUpperBounded : Prop

end SigmaR.Valuation.Measures.Monotonicity
