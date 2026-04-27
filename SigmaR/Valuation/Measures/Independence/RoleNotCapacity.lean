import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Standing.RoleState_Definition
import SigmaR.Valuation.Measures.CapacityMeasure_Definition

/-!
###############################################################################
# Independence: Role ≠ Capacity
###############################################################################

This file establishes that institutional role occupancy
does not entail agent-level capacity.

Role occupancy is an institutional or permissioned descriptor.
Capacity measures agent ability or potential.

Importing this file explicitly rejects any assumption that
holding a role guarantees capacity.
###############################################################################
-/

namespace SigmaR

/--
There is no general implication from role state
to capacity measures.
Any relationship between these concepts must be introduced explicitly.
-/
axiom role_not_capacity :
  ¬ (∀ (a : Agent) (s : State),
       RoleState a s → CapacityMeasure a s)

end SigmaR

/-!
## Interpretation

This prevents downstream users from assuming that:
- institutional position implies ability
- permission substitutes for capacity
- roles collapse into competence

Role occupancy and capacity are distinct structural facts.
-/

