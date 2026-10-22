import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.DerivedValuations.CouplingValuation.CouplingValuation

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

namespace SigmaR.Valuation.DerivedValuations.CouplingValuation

/--
CouplingRespectsMonotonicity C means that coupling valuation C
does not violate declared monotonicity constraints.
-/
axiom CouplingRespectsMonotonicity :
  CouplingValuation → Prop

end SigmaR.Valuation.DerivedValuations.CouplingValuation
