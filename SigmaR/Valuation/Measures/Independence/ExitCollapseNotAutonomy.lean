import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Measures.ExitCollapse_Definition
import SigmaR.Valuation.Measures.AutonomyMeasure_Definition

/-!
###############################################################################
# Independence: Exit Collapse ≠ Autonomy
###############################################################################

Exit collapse does not entail loss of autonomy.

An agent may retain autonomy despite the absence of viable exit,
and autonomy may be constrained without full exit collapse.
###############################################################################
-/

namespace SigmaR

/--
There is no general implication from exit collapse
to loss of autonomy.
-/
axiom exit_collapse_not_autonomy :
  ¬ (∀ (a : Agent) (s : State),
       ExitCollapse a s → AutonomyMeasure a s)

end SigmaR
