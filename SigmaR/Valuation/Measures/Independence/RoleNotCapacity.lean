import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Core.StructuralInterfaces
import SigmaR.Valuation.Measures.Definitions.RoleState_Definition
import SigmaR.Valuation.Measures.Definitions.CapacityMeasure_Definition

open SigmaR.Valuation.Core

/-!
###############################################################################
# Independence: Role Not Capacity
###############################################################################

Institutional role occupancy does not license or imply
agent-level capacity.

Role occupancy is an institutional or permissioned descriptor.
Capacity measures agent ability or potential.

No default implication from role occupancy to capacity
is licensed.
###############################################################################
-/

namespace SigmaR.Valuation.Measures.Independence

/--
No implication treating role occupancy as constituting
or licensing capacity is permitted.
-/
axiom role_not_capacity :
  ¬ (
    ∀ (a : Agent) (s : State),
      TreatedAsCapacityFromRoleState a s
  )

end SigmaR.Valuation.Measures.Independence
