import StandingAlgebra_FormalCore
import RoleState_Definition
import ExitViability_Definition

/-!
###############################################################################
# Role ≠ Exit
###############################################################################

Institutional role does not guarantee exit viability,
and exit viability does not assign roles.

Exit concerns refusal and non-coercion.
###############################################################################
-/

axiom RoleNotExit :
  ∀ (a : Agent) (s : State),
    (if RoleState a s then 1 else 0) ≠ (if ExitViable a s then 1 else 0)
