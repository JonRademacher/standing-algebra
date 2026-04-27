import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Measures.StructuralDebt_Definition
import SigmaR.Standing.RoleState_Definition

/-!
###############################################################################
# Independence: Structural Debt ≠ Role
###############################################################################

This file establishes that structural debt does not entail
institutional role occupancy.

Structural debt tracks accumulated obligation or unresolved
asymmetry within a system.
Roles describe institutional or permissioned positions.

Importing this file explicitly rejects any assumption that
debt determines role assignment.
###############################################################################
-/

namespace SigmaR

/--
There is no general implication from structural debt
to role state.
Any relationship between these concepts must be introduced explicitly.
-/
axiom debt_not_role :
  ¬ (∀ (a : Agent) (s : State),
       StructuralDebt a → RoleState a s)

end SigmaR

/-!
## Interpretation

This prevents downstream users from assuming that:
- obligation confers office
- debt determines institutional position
- structural asymmetry licenses role assignment

Debt constrains; roles are assigned.
-/
