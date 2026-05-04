import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.DerivedValuations.ExitCostValuation

/-!
###############################################################################
# Exit Cost Respects Monotonicity
###############################################################################

This file introduces the constraint that exit cost valuations
respect declared monotonicity conditions.

It does NOT:
• assert monotonicity
• enforce irreversibility
• imply correctness

It prevents illicit violations only.
###############################################################################
-/

namespace SigmaR

/--
ExitCostRespectsMonotonicity E means that exit cost valuation E
does not violate declared monotonicity constraints.
-/
constant ExitCostRespectsMonotonicity :
  ExitCostValuation → Prop

end SigmaR
