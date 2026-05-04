import SigmaR.StandingAlgebra_FormalCore

/-!
###############################################################################
# Exit Cost Valuation Scope
###############################################################################

Exit cost valuation is always relative to an explicitly
declared scope, context, or system boundary.

It must never be assumed to apply globally.

This file introduces no axioms.
###############################################################################
-/

namespace SigmaR

/--
Exit cost valuation is explicitly scoped and
never globally applicable by default.
-/
constant ExitCostValuationScope : Prop

end SigmaR
