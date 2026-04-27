import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Standing.ConsentState_Definition
import SigmaR.Standing.RoleState_Definition

/-!
###############################################################################
# Independence: Consent ≠ Role
###############################################################################

This file establishes that consent does not entail role occupancy.

Consent describes whether participation is voluntary.
Role describes an institutional or permissioned position.
No implication from consent to role is assumed.

Importing this file explicitly rejects any assumption that
agreement constitutes institutional role occupancy.
###############################################################################
-/

namespace SigmaR

/--
There is no general implication from consent to role state.
Any relationship between these concepts must be introduced explicitly.
-/
axiom consent_not_role :
  ¬ (∀ (a : Agent) (s : State),
       ConsentState a s → RoleState a s)

end SigmaR

/-!
## Interpretation

This prevents downstream users from assuming that:
- agreement implies institutional position
- consent grants authority or office
- voluntariness substitutes for role assignment

Consent and role occupancy are structurally distinct.
-/
