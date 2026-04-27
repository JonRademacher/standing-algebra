import StandingAlgebra_FormalCore
import ConsentState_Definition
import RoleState_Definition

/-!
###############################################################################
# Consent ≠ Role
###############################################################################

Consent describes whether participation is voluntary.

Role describes institutional or permissioned position.

Consent does not constitute role occupancy, and
role occupancy does not guarantee consent.
###############################################################################
-/

axiom ConsentNotRole :
  ∀ (a : Agent) (s : State),
    (if ConsentState a s then 1 else 0) ≠ (if RoleState a s then 1 else 0)
