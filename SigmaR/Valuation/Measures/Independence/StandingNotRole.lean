import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Core.StructuralInterfaces
import SigmaR.Valuation.Measures.StandingMeasure_Definition
import SigmaR.Standing.RoleState_Definition

/-!
###############################################################################
# Independence: Standing Not Role
###############################################################################

Standing does not license or imply institutional role occupancy.

Standing measures recognition or admissible participation.
Role occupancy describes institutional position or permission.

No default implication from standing to role assignment
is licensed.
###############################################################################
-/

namespace SigmaR

/--
No implication treating standing as constituting,
assigning, or licensing institutional role occupancy
is permitted.
-/
axiom standing_not_role :
  ¬ (
    ∀ (a : Agent) (s : State),
      TreatedAsRoleFromStandingMeasure a s
  )

end SigmaR
