import StandingAlgebra_FormalCore
import RoleState_Definition
import RiskLoad_Definition

/-!
###############################################################################
# Role ≠ Risk
###############################################################################

Institutional role does not determine risk exposure,
and risk exposure does not assign roles.

Risk is inherited exposure, not institutional position.
###############################################################################
-/

axiom RoleNotRisk :
  ∀ (a : Agent) (s : State),
    (if RoleState a s then 1 else 0) ≠ RiskLoad a s
