import SigmaR.StandingAlgebra_FormalCore

/-!
###############################################################################
# Admissible Irreversibility
###############################################################################

This file governs admissibility of irreversibility assumptions
in valuation reasoning.

Irreversibility must never be implied; it must be explicitly
declared to be admissible.
###############################################################################
-/

namespace SigmaR.Valuation.Admissibility

/--
Assumptions of irreversibility are admissible only when
explicitly declared.
-/
axiom AdmissibleIrreversibility : Measure → Prop

end SigmaR.Valuation.Admissibility
