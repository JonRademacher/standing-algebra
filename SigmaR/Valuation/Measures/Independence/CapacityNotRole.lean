import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Measures.CapacityMeasure_Definition
import SigmaR.Valuation.Measures.RoleState_Definition

/-!
###############################################################################
# Independence: Capacity ≠ Role
###############################################################################

This file establishes that role occupancy does not entail capacity.

Roles are institutional descriptors tied to permission or position.
Capacity is an agent-internal measure of ability or potential.
No implication between these notions is assumed.

Importing this file explicitly rejects any attempt to reduce
capacity to role occupancy.
###############################################################################
-/

namespace SigmaR

/--
There is no general implication from role state to capacity measures.
Any relationship between these concepts must be introduced explicitly.
-/
axiom role_not_capacity :
  ¬ (∀ (a : Agent) (s : State),
       RoleState a s → CapacityMeasure a s)

end SigmaR

/-!
## Interpretation

This prevents downstream users from assuming that:
- holding a role implies ability
- permission substitutes for capacity
- institutional status can proxy agent competence

Roles describe position; capacity describes potential.
-/

