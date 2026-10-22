import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Core.StructuralInterfaces
import SigmaR.Valuation.Measures.Definitions.ExitCollapse_Definition
import SigmaR.Valuation.Measures.Definitions.AutonomyMeasure_Definition

open SigmaR.Valuation.Core

/-!
###############################################################################
# Independence: Exit Collapse Not Autonomy
###############################################################################

Exit collapse does not license or imply loss of autonomy.

Exit collapse concerns the absence of viable exit.
Autonomy measures freedom from coercive constraint.

No default implication from exit collapse to loss of
autonomy is licensed.
###############################################################################
-/

namespace SigmaR.Valuation.Measures.Independence

/--
No implication treating exit collapse as eliminating,
revoking, or licensing the absence of autonomy is permitted.
-/
axiom exit_collapse_not_autonomy :
  ¬ (
    ∀ (a : Agent) (s : State),
      TreatedAsAutonomyLostFromExitCollapse a s
  )

end SigmaR.Valuation.Measures.Independence
