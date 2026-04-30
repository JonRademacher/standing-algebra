import SigmaR.StandingAlgebra_FormalCore

/-!
###############################################################################
# Admissibility Scope
###############################################################################

Admissibility is always relative to an explicitly declared
scope, context, or system boundary.

It must never be assumed to apply globally.
###############################################################################
-/

namespace SigmaR

/--
Admissibility is treated as explicitly scoped and
never globally applicable by default.
-/
constant AdmissibilityScope : Prop

end SigmaR
