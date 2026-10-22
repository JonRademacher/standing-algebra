import SigmaR.StandingAlgebra_FormalCore

/-!
###############################################################################
# Admissible Context Binding
###############################################################################

This file defines admissibility constraints that depend on
explicit context binding.

Admissibility may vary across:
• agents
• frames
• systems
• declared contexts

This file introduces no axioms.
###############################################################################
-/

namespace SigmaR.Valuation.Admissibility

/--
Admissibility is always relative to an explicit context
and must not be assumed globally.
-/
axiom AdmissibleContextBinding : Prop

end SigmaR.Valuation.Admissibility
