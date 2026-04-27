import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Measures.AutonomyMeasure_Definition
import SigmaR.Valuation.Measures.RoleState_Definition

/-!
###############################################################################
# Independence: Autonomy ≠ Role
###############################################################################

This file establishes that role occupancy does not entail autonomy.

Roles are institutional, descriptive, and consent-bounded.
Autonomy is a structural measure of freedom from coercive constraint.
No implication between these notions is assumed.

Importing this file explicitly rejects any attempt to reduce autonomy
to role occupancy or permission.
###############################################################################
-/

namespace SigmaR

/--
There is no general implication from role state to autonomy measures.
Any relationship between these concepts must be introduced explicitly.
-/
axiom role_not_autonomy :
  ¬ (∀ (a : Agent) (s : State),
       RoleState a s → AutonomyMeasure a s)

end SigmaR

/-!
## Interpretation

This prevents downstream users from assuming that:
- holding a role implies freedom
- permission implies agency
- institutional status substitutes for autonomy

Roles describe position; autonomy describes constraint.
-/
