import SigmaR.StandingAlgebra_FormalCore

/-!
###############################################################################
# Coupling Valuation Scope
###############################################################################

Coupling valuation is always relative to an explicitly
declared scope, context, or system boundary.

It must never be assumed to apply globally.

This file introduces no axioms.
###############################################################################
-/

namespace SigmaR

/--
Coupling valuation is explicitly scoped and
never globally applicable by default.
-/
constant CouplingValuationScope : Prop

end SigmaR
