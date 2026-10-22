import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Core.StructuralInterfaces
import SigmaR.Valuation.Measures.Definitions.RoleState_Definition
import SigmaR.Valuation.Measures.Definitions.AutonomyMeasure_Definition

open SigmaR.Valuation.Core

/-!
###############################################################################
# Independence: Role Not Autonomy
###############################################################################

Role occupancy does not license or imply autonomy.

Role occupancy is an institutional or permissioned descriptor.
Autonomy measures agent-level freedom from coercive constraint.

No default implication from role occupancy to autonomy
is licensed.
###############################################################################
-/

namespace SigmaR.Valuation.Measures.Independence

/--
No implication treating role occupancy as constituting
or licensing autonomy is permitted.
-/
axiom role_not_autonomy :
  ¬ (
    ∀ (a : Agent) (s : State),
      TreatedAsAutonomyFromRoleState a s
  )

end SigmaR.Valuation.Measures.Independence
