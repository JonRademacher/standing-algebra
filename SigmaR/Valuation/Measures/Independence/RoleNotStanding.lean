import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Core.StructuralInterfaces
import SigmaR.Valuation.Measures.Definitions.RoleState_Definition
import SigmaR.Valuation.Measures.Definitions.StandingMeasure_Definition

open SigmaR.Valuation.Core

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

namespace SigmaR.Valuation.Measures.Independence

/--
No implication treating role occupancy as constituting,
generating, or licensing standing is permitted.
-/
axiom role_not_standing :
  ¬ (
    ∀ (a : Agent) (s : State),
      TreatedAsStandingFromRoleState a s
  )

end SigmaR.Valuation.Measures.Independence
