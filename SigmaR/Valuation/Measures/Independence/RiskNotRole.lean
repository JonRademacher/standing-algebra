import StandingAlgebra_FormalCore
import RiskLoad_Definition
import RoleState_Definition

/-!
###############################################################################
# Risk ≠ Role
###############################################################################

Institutional role does not determine risk exposure,
and risk exposure does not assign roles.

They must not collapse definitionally.
###############################################################################
-/

axiom RiskNotRole :
  ∀ (a : Agent) (s : State),
    RiskLoad a s ≠ (if RoleState a s then 1 else 0)
