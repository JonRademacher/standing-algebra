import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Core.StructuralInterfaces
import SigmaR.Valuation.Measures.Definitions.DominationPressure_Definition
import SigmaR.Valuation.Measures.Definitions.RoleState_Definition

open SigmaR.Valuation.Core

/-!
###############################################################################
# Independence: Domination Pressure Not Role
###############################################################################

Domination pressure is a system-level diagnostic of structural
instability or approach to collapse.
Role occupancy is an institutional descriptor of position
or permission.

No default implication from domination pressure to role
assignment is licensed.
###############################################################################
-/

namespace SigmaR.Valuation.Measures.Independence

/--
No implication treating domination pressure as constituting,
assigning, or licensing institutional role occupancy is permitted.
-/
axiom domination_pressure_not_role :
  ¬ (
    ∀ (a : Agent) (s : State),
      TreatedAsRoleFromDominationPressure a s
  )

end SigmaR.Valuation.Measures.Independence
