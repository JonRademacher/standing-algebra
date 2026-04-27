import StandingAlgebra_FormalCore
import RoleState_Definition
import StructuralDebt_Definition

/-!
###############################################################################
# Role ≠ Structural Debt
###############################################################################

Role occupancy does not eliminate structural debt,
and structural debt does not assign institutional roles.

Debt tracks unresolved asymmetry; roles are
institutional descriptors.
###############################################################################
-/

axiom RoleNotDebt :
  ∀ (a : Agent) (s : State),
    (if RoleState a s then 1 else 0) ≠ StructuralDebt a
