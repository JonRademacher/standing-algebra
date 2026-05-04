import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.DerivedValuations.PerceptionValuation
import SigmaR.Valuation.ResponseSemantics.Response

/-!
###############################################################################
# Perception Depends On Response
###############################################################################

This file introduces structural dependency of perception
valuation on response semantics.

Dependency does NOT imply:
• authorization of response
• desirability of response
• intervention

It is structural sensitivity only.
###############################################################################
-/

namespace SigmaR

/--
PerceptionDependsOnResponse P R means that perception valuation P
is structurally sensitive to response R.
-/
constant PerceptionDependsOnResponse :
  PerceptionValuation → Response → Prop

end SigmaR
