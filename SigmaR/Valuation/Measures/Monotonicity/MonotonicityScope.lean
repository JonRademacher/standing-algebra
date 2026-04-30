import SigmaR.StandingAlgebra_FormalCore

/-!
###############################################################################
# Monotonicity Scope (Contract)
###############################################################################

Monotonicity axioms apply only within an explicitly
declared state ordering and system context.

They do not apply globally or across unrelated states.

This file introduces no axioms.
It defines a binding interpretive contract for the
Monotonicity layer.
###############################################################################
-/

namespace SigmaR

/--
Monotonicity relations are treated as scoped to
an explicit state ordering and system context.
-/
constant MonotonicityRequiresScope : Prop

end SigmaR
