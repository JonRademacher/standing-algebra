import StandingAlgebra_FormalCore
import CapacityMeasure_Definition
import RoleState_Definition

/-!
###############################################################################
# Capacity ≠ Role
###############################################################################

Role occupancy or permission does not constitute capacity.

Capacity is structural and agent-internal; roles are
institutional descriptors.
###############################################################################
-/

axiom CapacityNotRole :
  ∀ (a : Agent) (s : State),
    CapacityMeasure a s ≠ (if RoleState a s then 1 else 0)
