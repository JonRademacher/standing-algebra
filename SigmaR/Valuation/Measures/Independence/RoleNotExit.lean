import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Standing.RoleState_Definition
import SigmaR.Valuation.Measures.ExitViability_Definition

/-!
###############################################################################
# Independence: Role ≠ Exit Viability
###############################################################################

This file establishes that institutional role occupancy does not
entail exit viability.

Roles are institutional descriptors of position or permission.
Exit viability concerns the structural ability to refuse or withdraw.

Importing this file explicitly rejects any assumption that
holding an institutional role guarantees a viable exit.
###############################################################################
-/

namespace SigmaR

/--
There is no general implication from role state
to exit viability.
Any relationship between these concepts must be introduced explicitly.
-/
axiom role_not_exit :
  ¬ (∀ (a : Agent) (s : State),
       RoleState a s → ExitViable a)

end SigmaR

/-!
## Interpretation

This prevents downstream users from assuming that:
- institutional position guarantees freedom to leave
- permission substitutes for non-coercion
- exit viability collapses into role assignment

Roles and exit viability are distinct structural facts.
-/
