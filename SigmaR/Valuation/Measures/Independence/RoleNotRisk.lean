import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Core.StructuralInterfaces
import SigmaR.Valuation.Measures.Definitions.RoleState_Definition
import SigmaR.Valuation.Measures.Definitions.RiskLoad_Definition

open SigmaR.Valuation.Core

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

namespace SigmaR.Valuation.Measures.Independence

/--
No implication treating role occupancy as constituting,
determining, or licensing risk exposure is permitted.
-/
axiom role_not_risk :
  ¬ (
    ∀ (a : Agent) (s : State),
      TreatedAsRiskFromRoleState a s
  )

end SigmaR.Valuation.Measures.Independence
