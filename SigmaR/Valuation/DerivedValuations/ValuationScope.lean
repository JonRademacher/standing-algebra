import SigmaR.StandingAlgebra_FormalCore

/-!
###############################################################################
# Valuation Scope
###############################################################################

Derived valuations are always relative to an explicitly
declared scope, context, or system boundary.

They must never be assumed to apply globally.
###############################################################################
-/

namespace SigmaR

/--
Derived valuations are explicitly scoped
and never globally applicable by default.
-/
constant ValuationScope : Prop

end SigmaR
