import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.DerivedValuations.StandingValuation.StandingValuation

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

namespace SigmaR.Valuation.DerivedValuations.StandingValuation

/--
StandingRespectsMonotonicity S means that standing valuation S
does not violate declared monotonicity constraints.
-/
axiom StandingRespectsMonotonicity :
  StandingValuation → Prop

end SigmaR.Valuation.DerivedValuations.StandingValuation
