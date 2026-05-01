import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.DerivedValuations.DerivedValuation

/-!
###############################################################################
# Valuation Respects Monotonicity
###############################################################################

This file introduces the constraint that derived valuations
respect declared monotonicity conditions.

It does NOT:
• assert monotonicity
• enforce irreversibility
• imply correctness

It only prevents illicit violations.
###############################################################################
-/

namespace SigmaR

/--
ValuationRespectsMonotonicity V means that derived valuation V
does not violate declared monotonicity constraints.
-/
constant ValuationRespectsMonotonicity :
  DerivedValuation → Prop

end SigmaR
