import StandingAlgebra_FormalCore
import DominationPressure_Definition
import RoleState_Definition

/-!
###############################################################################
# Domination Pressure ≠ Role
###############################################################################

Role occupancy is an institutional descriptor.

Domination pressure is a systemic diagnostic.

Institutional roles do not prevent domination, and
domination pressure does not assign roles.
###############################################################################
-/

axiom DominationPressureNotRole :
  ∀ (a : Agent) (s : State),
    DominationPressure s ≠ (if RoleState a s then 1 else 0)
