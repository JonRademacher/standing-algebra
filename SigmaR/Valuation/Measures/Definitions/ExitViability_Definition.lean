import SigmaR.StandingAlgebra_FormalCore

/-!
###############################################################################
# Exit Viability — Definition
###############################################################################

ExitViable a records whether agent a retains
a structurally meaningful ability to exit or refuse coordination.

Exit viability is structural and non-numeric.

Any logical properties (e.g. decidability) are introduced
only in higher layers or specific models.
###############################################################################
-/

namespace SigmaR

/--
ExitViable a means agent a retains meaningful exit options.
-/
constant ExitViable : Agent → Prop

end SigmaR
