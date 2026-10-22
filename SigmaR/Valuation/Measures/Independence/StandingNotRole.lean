import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Core.StructuralInterfaces
import SigmaR.Valuation.Measures.Definitions.StandingMeasure_Definition
import SigmaR.Valuation.Measures.Definitions.RoleState_Definition

open SigmaR.Valuation.Core

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

namespace SigmaR.Valuation.Measures.Independence

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

end SigmaR.Valuation.Measures.Independence
