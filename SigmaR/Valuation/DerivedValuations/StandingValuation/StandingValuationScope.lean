import SigmaR.StandingAlgebra_FormalCore

/-!
###############################################################################
# Standing Valuation Scope
###############################################################################

Standing valuation is always relative to an explicitly
declared scope, context, or system boundary.

It must never be assumed to apply globally.

This file introduces no axioms.
###############################################################################
-/

namespace SigmaR

/--
Standing valuation is explicitly scoped and never
globally applicable by default.
-/
constant StandingValuationScope : Prop

end SigmaR
