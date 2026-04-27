import StandingAlgebra_FormalCore
import RoleState_Definition
import CapacityMeasure_Definition

/-!
###############################################################################
# Role ≠ Capacity
###############################################################################

Institutional role does not guarantee capacity, and
capacity does not imply institutional role.

They must remain definitionally distinct.
###############################################################################
-/

axiom RoleNotCapacity :
  ∀ (a : Agent) (s : State),
    (if RoleState a s then 1 else 0) ≠ CapacityMeasure a s
