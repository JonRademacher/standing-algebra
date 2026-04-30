import SigmaR.StandingAlgebra_FormalCore

/-!
###############################################################################
# Admissible Under Monotonicity
###############################################################################

This file defines admissibility constraints imposed by the
Monotonicity layer.

Monotonicity assumptions must be explicitly declared,
scoped, and respected.
###############################################################################
-/

namespace SigmaR

/--
Admissibility of reasoning respects declared monotonicity
constraints and contracts.
-/
constant AdmissibleUnderMonotonicity : Prop

end SigmaR
