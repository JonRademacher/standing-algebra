import SigmaR.StandingAlgebra_FormalCore

/-!
###############################################################################
# Derived Valuations Contract
###############################################################################

This file defines the governing interpretive rules of the
Derived Valuations layer in SigmaR.

Derived valuations:
• compute values from structure
• do not assert truth or correctness
• do not imply legitimacy or morality
• do not grant authority or justify intervention
• respect WellFormedness, Independence, Monotonicity,
  Admissibility, and ResponseSemantics
• are always explicitly scoped

This file introduces no axioms.
###############################################################################
-/

namespace SigmaR

/--
The Derived Valuations layer is governed by an explicit
interpretive contract defining its scope and limits.
-/
constant DerivedValuationsContract : Prop

end SigmaR
