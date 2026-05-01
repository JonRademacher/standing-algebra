import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.DerivedValuations.StandingValuation

/-!
###############################################################################
# Standing Respects Monotonicity
###############################################################################

This file introduces the constraint that standing valuations
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
StandingRespectsMonotonicity S means that standing valuation S
does not violate declared monotonicity constraints.
-/
constant StandingRespectsMonotonicity :
  StandingValuation → Prop

end SigmaR
