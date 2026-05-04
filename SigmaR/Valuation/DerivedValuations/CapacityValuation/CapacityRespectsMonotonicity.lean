import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.DerivedValuations.CapacityValuation.CapacityValuation

/-!
###############################################################################
# Capacity Respects Monotonicity
###############################################################################

This file introduces the constraint that capacity valuations
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
CapacityRespectsMonotonicity C means that capacity valuation C
does not violate declared monotonicity constraints.
-/
constant CapacityRespectsMonotonicity :
  CapacityValuation → Prop

end SigmaR
