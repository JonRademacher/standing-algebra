import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Measures.ExitCollapse_Definition
import SigmaR.Valuation.Measures.StandingMeasure_Definition

/-!
###############################################################################
# Independence: Exit Collapse Not Standing
###############################################################################

Exit collapse does not entail loss of standing.

Recognition or admissible participation may persist
despite the absence of viable exit.
###############################################################################
-/

namespace SigmaR

/--
There is no general implication from exit collapse
to loss of standing.
-/
axiom exit_collapse_not_standing :
  ¬ (∀ (a : Agent) (s : State),
       ExitCollapse a s → ¬ StandingMeasure a s)

end SigmaR
