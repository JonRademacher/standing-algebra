import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Core.StructuralInterfaces
import SigmaR.Standing.RoleState_Definition
import SigmaR.Valuation.Measures.StandingMeasure_Definition

/-!
###############################################################################
# Independence: Role Not Standing
###############################################################################

Institutional role occupancy does not license or imply standing.

Roles are institutional descriptors of position or permission.
Standing measures recognized admissibility or participation
within a system.

No default implication from role occupancy to standing
is licensed.
###############################################################################
-/

namespace SigmaR

/--
No implication treating role occupancy as constituting,
generating, or licensing standing is permitted.
-/
axiom role_not_standing :
  ¬ (
    ∀ (a : Agent) (s : State),
      TreatedAsStandingFromRoleState a s
  )

end SigmaR
