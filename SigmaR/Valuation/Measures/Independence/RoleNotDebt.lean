import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Standing.RoleState_Definition
import SigmaR.Valuation.Measures.StructuralDebt_Definition

/-!
###############################################################################
# Independence: Role Not Structural Debt
###############################################################################

This file establishes that institutional role occupancy does not
entail elimination or resolution of structural debt.

Structural debt tracks unresolved asymmetry or obligation
within a system.
Roles are institutional descriptors of position or permission.

Importing this file explicitly rejects any assumption that
holding a role clears or resolves structural debt.
###############################################################################
-/

namespace SigmaR

/--
There is no general implication from role state
to the absence or resolution of structural debt.
Any relationship between these concepts must be introduced explicitly.
-/
axiom role_not_debt :
  ¬ (∀ (a : Agent) (s : State),
       RoleState a s → StructuralDebt a)

end SigmaR

/-!
## Interpretation

This prevents downstream users from assuming that:
- institutional position cancels obligation
- role occupancy resolves asymmetry
- debt collapses into role assignment

Roles and structural debt are distinct structural facts.
-/

