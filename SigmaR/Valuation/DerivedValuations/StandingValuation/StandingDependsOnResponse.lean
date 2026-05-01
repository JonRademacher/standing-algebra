import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.DerivedValuations.StandingValuation
import SigmaR.Valuation.ResponseSemantics.Response

/-!
###############################################################################
# Standing Depends On Response
###############################################################################

This file introduces structural dependency of standing valuation
on response semantics.

Dependency does NOT imply:
• authorization of response
• desirability of response
• intervention
###############################################################################
-/

namespace SigmaR

/--
StandingDependsOnResponse S R means that standing valuation S
is structurally sensitive to response R.
-/
constant StandingDependsOnResponse :
  StandingValuation → Response → Prop

end SigmaR
