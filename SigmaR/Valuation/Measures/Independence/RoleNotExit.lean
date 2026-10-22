import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Core.StructuralInterfaces
import SigmaR.Valuation.Measures.Definitions.RoleState_Definition
import SigmaR.Valuation.Measures.Definitions.ExitViability_Definition

open SigmaR.Valuation.Core

/-!
###############################################################################
# Independence: Role Not Exit Viability
###############################################################################

Institutional role occupancy does not license or imply exit viability.

Roles are institutional descriptors of position or permission.
Exit viability concerns the structural ability to refuse or withdraw.

No default implication from role occupancy to exit viability
is licensed.
###############################################################################
-/

namespace SigmaR.Valuation.Measures.Independence

/--
No implication treating role occupancy as guaranteeing,
constituting, or licensing exit viability is permitted.
-/
axiom role_not_exit :
  ¬ (
    ∀ (a : Agent) (s : State),
      TreatedAsExitViableFromRoleState a s
  )

end SigmaR.Valuation.Measures.Independence
