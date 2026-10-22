import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.DerivedValuations.StandingValuation.StandingValuation
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

namespace SigmaR.Valuation.DerivedValuations.StandingValuation

/--
StandingDependsOnResponse S R means that standing valuation S
is structurally sensitive to response R.
-/
axiom StandingDependsOnResponse :
  StandingValuation → Response → Prop

end SigmaR.Valuation.DerivedValuations.StandingValuation
