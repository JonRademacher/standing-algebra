import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Measures.RoleState_Definition
import SigmaR.Valuation.Measures.StandingMeasure_Definition

/-!
###############################################################################
# Standing ≠ Role
###############################################################################

Standing does not entail any particular role,
permission, or institutional authority.
###############################################################################
-/

namespace SigmaR

axiom StandingNotRole :
  ∀ (a : Agent) (s : State),
    StandingMeasure a s ≠ 0 →
    RoleState a s ≠ True

end SigmaR
