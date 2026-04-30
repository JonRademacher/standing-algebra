import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Core.StructuralInterfaces
import SigmaR.Standing.RoleState_Definition
import SigmaR.Valuation.Measures.DominationPressure_Definition

/-!
###############################################################################
# Independence: Role Not Domination Pressure
###############################################################################

Institutional role occupancy does not license or imply
domination pressure.

Roles are institutional descriptors of position or permission.
Domination pressure is a system-level diagnostic of structural
instability or approach to collapse.

No default implication from role occupancy to domination
pressure is licensed.
###############################################################################
-/

namespace SigmaR

/--
No implication treating role occupancy as constituting,
determining, or licensing domination pressure is permitted.
-/
axiom role_not_domination_pressure :
  ¬ (
    ∀ (a : Agent) (s : State),
      TreatedAsDominationPressureFromRoleState a s
  )

end SigmaR
