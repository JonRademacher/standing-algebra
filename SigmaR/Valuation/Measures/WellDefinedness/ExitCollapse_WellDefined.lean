import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Measures.ExitCollapse_Definition

/-!
###############################################################################
# Exit Collapse — Well-Definedness
###############################################################################

Ensures that exit collapse is a determinate structural condition.
###############################################################################
-/

namespace SigmaR

/--
Exit collapse is well-defined if it is a total predicate
over agents and states.
-/
def ExitCollapse_WellDefined : Prop :=
  ∀ (i : Agent) (s : State), ExitCollapse i s ∨ ¬ ExitCollapse i s

end SigmaR
