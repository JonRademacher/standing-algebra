import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Measures.ExitCollapse_Definition
import SigmaR.Valuation.Measures.CapacityMeasure_Definition

/-!
###############################################################################
# Independence: Exit Collapse ≠ Capacity
###############################################################################

Exit collapse does not entail loss of capacity.

An agent may retain ability or potential even when
structural exit has collapsed.
###############################################################################
-/

namespace SigmaR

/--
There is no general implication from exit collapse
to loss of capacity.
-/
axiom exit_collapse_not_capacity :
  ¬ (∀ (a : Agent) (s : State),
       ExitCollapse a s → CapacityMeasure a s)

end SigmaR
