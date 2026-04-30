import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Core.StructuralInterfaces
import SigmaR.Standing.RoleState_Definition
import SigmaR.Valuation.Measures.CapacityMeasure_Definition

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

namespace SigmaR

/--
No implication treating role occupancy as constituting
or licensing capacity is permitted.
-/
axiom role_not_capacity :
  ¬ (
    ∀ (a : Agent) (s : State),
      TreatedAsCapacityFromRoleState a s
  )

end SigmaR
