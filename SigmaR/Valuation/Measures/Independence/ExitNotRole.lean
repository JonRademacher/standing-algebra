import StandingAlgebra_FormalCore
import ExitViability_Definition
import RoleState_Definition

/-!
###############################################################################
# Exit ≠ Role
###############################################################################

Role occupancy does not guarantee exit viability,
and exit viability does not assign roles.

Institutional position must not substitute for
structural refusal.
###############################################################################
-/

axiom ExitNotRole :
  ∀ (a : Agent) (s : State),
    (if ExitViable a s then 1 else 0) ≠ (if RoleState a s then 1 else 0)
