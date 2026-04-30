import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Measures.ExitCollapse_Definition
import SigmaR.Valuation.Measures.Monotonicity.MeasureStructuralMonotonicity

/-!
###############################################################################
# Exit Collapse Is Irreversible (Structural)
###############################################################################

Exit collapse is treated as non-reversible
along the state preorder in the absence of
explicit countervailing structure.

This file names the irreversibility constraint.
It does not assert it as a global semantic law.
###############################################################################
-/

namespace SigmaR

/--
Exit collapse is treated as irreversible
along the state preorder.
-/
constant ExitCollapseIrreversible : Prop

end SigmaR
