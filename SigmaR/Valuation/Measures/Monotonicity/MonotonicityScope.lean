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

namespace SigmaR.Valuation.Measures.Monotonicity

/--
Monotonicity relations are treated as scoped to
an explicit state ordering and system context.
-/
axiom MonotonicityRequiresScope : Prop

end SigmaR.Valuation.Measures.Monotonicity
