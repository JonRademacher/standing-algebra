import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Core.StructuralInterfaces
import SigmaR.Valuation.Measures.AutonomyMeasure_Definition
import SigmaR.Valuation.Measures.RoleState_Definition

/-!
###############################################################################
# Independence: Autonomy Not Role
###############################################################################

Role occupancy does not license or imply autonomy.
Any relationship between role state and autonomy must be
introduced explicitly in higher layers or models.
###############################################################################
-/

namespace SigmaR

/--
No implication treating role occupancy as implying
or licensing autonomy is permitted.
-/
axiom role_not_autonomy :
  ¬ (
    ∀ (a : Agent) (s : State),
      TreatedAsAutonomyFromRoleState a s
  )

end SigmaR
