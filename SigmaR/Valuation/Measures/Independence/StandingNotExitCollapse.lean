import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Measures.StandingMeasure_Definition
import SigmaR.Valuation.Measures.ExitCollapse_Definition

/-!
###############################################################################
# Independence: Standing ≠ Exit Collapse
###############################################################################

Standing does not entail exit collapse.

An agent may retain recognized standing while exit
remains viable or collapses independently.
###############################################################################
-/

namespace SigmaR

/--
There is no general implication from standing
to exit collapse.
-/
axiom standing_not_exit_collapse :
  ¬ (∀ (a : Agent) (s : State),
       StandingMeasure a s → ExitCollapse a s)

end SigmaR
