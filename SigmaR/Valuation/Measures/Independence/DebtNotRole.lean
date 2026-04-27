import StandingAlgebra_FormalCore
import StructuralDebt_Definition
import RoleState_Definition

/-!
###############################################################################
# Structural Debt ≠ Role
###############################################################################

Role occupancy does not cancel structural debt, and
structural debt does not determine institutional role.

Debt is structural; roles are institutional descriptors.
###############################################################################
-/

axiom DebtNotRole :
  ∀ (a : Agent) (s : State),
    StructuralDebt a ≠ (if RoleState a s then 1 else 0)
