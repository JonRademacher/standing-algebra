import StandingAlgebra_FormalCore
import RoleState_Definition
import ConsentState_Definition

/-!
###############################################################################
# Role ≠ Consent
###############################################################################

Institutional or permissioned role occupancy does not
constitute consent, and consent does not assign roles.

Roles are structural descriptors; consent is a
participation condition.
###############################################################################
-/

axiom RoleNotConsent :
  ∀ (a : Agent) (s : State),
    (if RoleState a s then 1 else 0) ≠ (if ConsentState a s then 1 else 0)
