import SigmaR.StandingAlgebra_FormalCore

/-!
###############################################################################
# Admissibility Contract
###############################################################################

This file defines the governing interpretive rules of the
Admissibility layer in SigmaR.

Admissibility:
• permits reasoning under declared constraints
• does not assert truth, validity, legitimacy, or authority
• does not authorize intervention or action
• respects WellFormedness, Independence, and Monotonicity
• is always explicitly scoped

This file introduces no axioms.
###############################################################################
-/

namespace SigmaR

/--
The Admissibility layer is governed by an explicit
interpretive contract defining its scope and limits.
-/
constant AdmissibilityContract : Prop

end SigmaR
