import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.DerivedValuations.AutonomyValuation.AutonomyValuation

/-!
###############################################################################
# Autonomy Respects Monotonicity
###############################################################################

This file introduces the constraint that autonomy
valuations respect declared monotonicity conditions.

It does NOT:
• assert monotonic increase or decrease of autonomy
• enforce irreversibility
• imply correctness or directionality
###############################################################################
-/

namespace SigmaR

/--
AutonomyRespectsMonotonicity A means that autonomy valuation A
does not violate declared monotonicity constraints.
-/
constant AutonomyRespectsMonotonicity :
  AutonomyValuation → Prop

end SigmaR
