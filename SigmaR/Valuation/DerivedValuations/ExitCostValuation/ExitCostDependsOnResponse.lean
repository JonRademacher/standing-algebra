import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.DerivedValuations.ExitCostValuation
import SigmaR.Valuation.ResponseSemantics.Response

/-!
###############################################################################
# Exit Cost Depends On Response
###############################################################################

This file introduces structural dependency of exit cost valuation
on response semantics.

Dependency does NOT imply:
• authorization of response
• desirability of response
• intervention

It is structural sensitivity only.
###############################################################################
-/

namespace SigmaR

/--
ExitCostDependsOnResponse E R means that exit cost valuation E
is structurally sensitive to response R.
-/
constant ExitCostDependsOnResponse :
  ExitCostValuation → Response → Prop

end SigmaR
