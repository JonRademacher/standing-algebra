import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.DerivedValuations.ExitCostValuation.ExitCostValuation

/-!
###############################################################################
# Exit Cost Depends On Context
###############################################################################

This file introduces structural dependency of exit cost valuation
on context.

Context dependence does NOT imply:
• relativism
• subjectivity
• authority

It is structural scoping only.
###############################################################################
-/

namespace SigmaR.Valuation.DerivedValuations.ExitCostValuation

/--
ExitCostDependsOnContext E means that exit cost valuation E
is explicitly context-dependent.
-/
axiom ExitCostDependsOnContext :
  ExitCostValuation → Prop

end SigmaR.Valuation.DerivedValuations.ExitCostValuation
