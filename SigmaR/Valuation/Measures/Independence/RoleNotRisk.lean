import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Core.StructuralInterfaces
import SigmaR.Standing.RoleState_Definition
import SigmaR.Valuation.Measures.RiskLoad_Definition

/-!
###############################################################################
# Independence: Role Not Risk
###############################################################################

Institutional role occupancy does not license or imply risk exposure.

Roles are institutional descriptors of position or permission.
Risk load captures inherited or situational exposure to harm.

No default implication from role occupancy to risk exposure
is licensed.
###############################################################################
-/

namespace SigmaR

/--
No implication treating role occupancy as constituting,
determining, or licensing risk exposure is permitted.
-/
axiom role_not_risk :
  ¬ (
    ∀ (a : Agent) (s : State),
      TreatedAsRiskFromRoleState a s
  )

end SigmaR
