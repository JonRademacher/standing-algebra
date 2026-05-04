import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.DerivedValuations.AutonomyValuation.AutonomyValuation
import SigmaR.Valuation.ResponseSemantics.Response

/-!
###############################################################################
# Autonomy Depends On Response
###############################################################################

This file introduces the structural dependency of autonomy
valuation on response semantics.

Dependency does NOT imply:
• authorization of response
• desirability of response
• intervention

It is purely structural sensitivity.
###############################################################################
-/

namespace SigmaR

/--
AutonomyDependsOnResponse A R means that autonomy valuation A
is structurally sensitive to response R.
-/
constant AutonomyDependsOnResponse :
  AutonomyValuation → Response → Prop

end SigmaR
