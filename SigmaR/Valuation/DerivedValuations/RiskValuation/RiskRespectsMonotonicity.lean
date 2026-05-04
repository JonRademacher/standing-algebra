import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.DerivedValuations.RiskValuation.RiskValuation

/-!
###############################################################################
# Risk Respects Monotonicity
###############################################################################

This file introduces the constraint that risk valuations
respect declared monotonicity conditions.

It does NOT:
• assert monotonic increase or decrease of risk
• enforce irreversibility
• imply correctness or prediction
###############################################################################
-/

namespace SigmaR

/--
RiskRespectsMonotonicity R means that risk valuation R
does not violate declared monotonicity constraints.
-/
constant RiskRespectsMonotonicity :
  RiskValuation → Prop

end SigmaR
