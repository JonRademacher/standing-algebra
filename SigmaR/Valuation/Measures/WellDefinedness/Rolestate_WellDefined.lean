import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Measures.RoleState_Definition

/-!
###############################################################################
# Role State — Well-Definedness
###############################################################################

Ensures role occupancy is a total, determinate
structural predicate.

No authorization or standing transfer
is implied.
###############################################################################
-/

namespace SigmaR

/--
RoleState is well-defined if it has a determinate
truth value for every agent and state.
-/
def RoleState_WellDefined : Prop :=
  ∀ (a : Agent) (s : State), RoleState a s ∨ ¬ RoleState a s

end SigmaR
