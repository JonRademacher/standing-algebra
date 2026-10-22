import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Core.StructuralInterfaces
import SigmaR.Valuation.Measures.Definitions.RoleState_Definition
import SigmaR.Valuation.Measures.Definitions.DominationPressure_Definition

open SigmaR.Valuation.Core

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

namespace SigmaR.Valuation.Measures.Independence

/--
No implication treating role occupancy as constituting,
determining, or licensing domination pressure is permitted.
-/
axiom role_not_domination_pressure :
  ¬ (
    ∀ (a : Agent) (s : State),
      TreatedAsDominationPressureFromRoleState a s
  )

end SigmaR.Valuation.Measures.Independence
