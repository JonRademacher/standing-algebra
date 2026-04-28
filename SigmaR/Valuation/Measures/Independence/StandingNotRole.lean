import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Standing.RoleState_Definition
import SigmaR.Valuation.Measures.StandingMeasure_Definition

/-!
###############################################################################
# Independence: Standing ≠ Role
###############################################################################

This file establishes that standing does not entail institutional role
occupancy.

Standing measures recognition or admissible participation.
Role occupancy describes institutional position or permission.

Importing this file explicitly rejects any assumption that
recognized standing assigns roles or authority.
###############################################################################
-/

namespace SigmaR

/--
There is no general implication from standing
to role state.
Any relationship between these concepts must be introduced explicitly.
-/
axiom standing_not_role :
  ¬ (∀ (a : Agent) (s : State),
       StandingMeasure a s → RoleState a s)

end SigmaR

/-!
## Interpretation

This prevents downstream users from assuming that:
- recognition confers authority
- admissibility substitutes for role assignment
- standing collapses into institutional position

Standing and role occupancy are distinct structural facts.
-/

