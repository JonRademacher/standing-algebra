import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Measures.Definitions.RiskLoad_Definition

/-!
###############################################################################
# Risk Is Upper Bounded (Structural)
###############################################################################

Risk exposure is treated as having a finite upper bound
within certain models or interpretive regimes.

This file names the boundedness constraint.
It does not assert it as a global semantic law.
###############################################################################
-/

namespace SigmaR.Valuation.Measures.Monotonicity

/--
Risk exposure is treated as upper bounded.
-/
axiom RiskUpperBounded : Prop

end SigmaR.Valuation.Measures.Monotonicity
