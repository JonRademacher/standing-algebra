import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Core.StructuralInterfaces
import SigmaR.Valuation.Measures.ExitCollapse_Definition
import SigmaR.Valuation.Measures.StandingMeasure_Definition

/-!
###############################################################################
# Independence: Exit Collapse Not Standing
###############################################################################

Exit collapse does not license or imply loss of standing.

Exit collapse concerns the absence of viable exit.
Standing measures recognized status or admissible participation.

No default implication from exit collapse to standing revocation
is licensed.
###############################################################################
-/

namespace SigmaR

/--
No implication treating exit collapse as eliminating,
revoking, or licensing the loss of standing is permitted.
-/
axiom exit_collapse_not_standing :
  ¬ (
    ∀ (a : Agent) (s : State),
      TreatedAsStandingRevokedFromExitCollapse a s
  )

end SigmaR
