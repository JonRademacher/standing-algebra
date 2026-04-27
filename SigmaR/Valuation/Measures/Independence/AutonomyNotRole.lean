import StandingAlgebra_FormalCore
import AutonomyMeasure_Definition
import RoleState_Definition

/-!
###############################################################################
# Autonomy ≠ Role
###############################################################################

Role occupancy or permission does not constitute autonomy.

Autonomy is structural and non-institutional; roles are
descriptive and consent-bounded.
###############################################################################
-/

axiom AutonomyNotRole :
  ∀ (a : Agent) (s : State),
    AutonomyMeasure a s ≠ (if RoleState a s then 1 else 0)
