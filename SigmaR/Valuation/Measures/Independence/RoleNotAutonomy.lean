import StandingAlgebra_FormalCore
import RoleState_Definition
import AutonomyMeasure_Definition

/-!
###############################################################################
# Role ≠ Autonomy
###############################################################################

Role occupancy or permission does not constitute autonomy.

Autonomy is structural and agent-level; roles are
institutional and descriptive.
###############################################################################
-/

axiom RoleNotAutonomy :
  ∀ (a : Agent) (s : State),
    (if RoleState a s then 1 else 0) ≠ AutonomyMeasure a s
