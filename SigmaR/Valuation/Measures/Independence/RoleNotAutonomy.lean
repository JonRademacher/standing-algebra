import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Standing.RoleState_Definition
import SigmaR.Valuation.Measures.AutonomyMeasure_Definition

/-!
###############################################################################
# Independence: Role ≠ Autonomy
###############################################################################

This file establishes that role occupancy does not entail autonomy.

Role occupancy is an institutional or permissioned descriptor.
Autonomy is an agent-level measure of freedom from coercive constraint.

Importing this file explicitly rejects any assumption that
institutional role or permission constitutes autonomy.
###############################################################################
-/

namespace SigmaR

/--
There is no general implication from role state
to autonomy measures.
Any relationship between these concepts must be introduced explicitly.
-/
axiom role_not_autonomy :
  ¬ (∀ (a : Agent) (s : State),
       RoleState a s → AutonomyMeasure a s)

end SigmaR

/-!
## Interpretation

This prevents downstream users from assuming that:
- permission implies freedom
- institutional position substitutes for autonomy
- roles collapse into agent-level liberty

Role occupancy and autonomy are distinct structural facts.
-/

