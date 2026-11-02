import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Core.StructuralInterfaces
import SigmaR.Valuation.Measures.Definitions.ExitCollapse_Definition
import SigmaR.Valuation.Measures.Definitions.CapacityMeasure_Definition

open SigmaR.Valuation.Core

/-!
###############################################################################
# Independence: Exit Collapse Not Capacity
###############################################################################

Exit collapse does not license or imply loss of capacity.

Exit collapse concerns the absence of viable exit.
Capacity measures agent-level ability or potential.

No default implication from exit collapse to loss of
capacity is licensed.
###############################################################################
-/

namespace SigmaR.Valuation.Measures.Independence

/--
No implication treating exit collapse as eliminating,
revoking, or licensing the absence of agent capacity
is permitted.
-/
axiom exit_collapse_not_capacity :
  ¬ (
    ∀ (a : Agent) (s : State),
      TreatedAsCapacityLostFromExitCollapse a s
  )

end SigmaR.Valuation.Measures.Independence
