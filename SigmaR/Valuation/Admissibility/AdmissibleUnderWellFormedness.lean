import SigmaR.StandingAlgebra_FormalCore

/-!
###############################################################################
# Admissible Under Well-Formedness
###############################################################################

This file defines the relationship between well-formedness
and admissibility.

Well-formedness is necessary but not sufficient for admissibility.
###############################################################################
-/

namespace SigmaR

/--
Admissibility requires satisfaction of well-formedness constraints,
but does not collapse into them.
-/
constant AdmissibleUnderWellFormedness : Prop

end SigmaR
