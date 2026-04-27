import StandingAlgebra_FormalCore
import RoleState_Definition
import DominationPressure_Definition

/-!
###############################################################################
# Role ≠ Domination Pressure
###############################################################################

Domination pressure is a system-level diagnostic of
structural instability.

Institutional roles do not prevent domination, and
domination pressure does not assign roles.
###############################################################################
-/

axiom RoleNotDominationPressure :
  ∀ (a : Agent) (s : State),
    (if RoleState a s then 1 else 0) ≠ DominationPressure s
