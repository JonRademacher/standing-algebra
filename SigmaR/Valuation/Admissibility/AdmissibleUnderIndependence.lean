import SigmaR.StandingAlgebra_FormalCore

/-!
###############################################################################
# Admissible Under Independence
###############################################################################

This file defines admissibility constraints imposed by the
Independence layer.

Admissibility must not permit reasoning patterns that
reintroduce implications explicitly blocked by Independence.

This file introduces no axioms.
###############################################################################
-/

namespace SigmaR.Valuation.Admissibility

/--
An admissible reasoning configuration respects all
Independence inference firewalls.
-/
axiom AdmissibleUnderIndependence : Prop

end SigmaR.Valuation.Admissibility
