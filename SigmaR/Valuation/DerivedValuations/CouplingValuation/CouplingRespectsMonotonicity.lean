import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.DerivedValuations.CouplingValuation

/-!
###############################################################################
# Coupling Respects Monotonicity
###############################################################################

This file introduces the constraint that coupling valuations
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
CouplingRespectsMonotonicity C means that coupling valuation C
does not violate declared monotonicity constraints.
-/
constant CouplingRespectsMonotonicity :
  CouplingValuation → Prop

end SigmaR
