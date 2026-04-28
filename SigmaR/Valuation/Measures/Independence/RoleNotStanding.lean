import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Standing.RoleState_Definition
import SigmaR.Valuation.Measures.StandingMeasure_Definition

/-!
###############################################################################
# Independence: Role Not Standing
###############################################################################

This file establishes that institutional role occupancy does not
entail standing.

Roles are institutional descriptors of position or permission.
Standing measures recognized admissibility or participation
within a system.

Importing this file explicitly rejects any assumption that
holding an institutional role generates standing.
###############################################################################
-/

namespace SigmaR

/--
There is no general implication from role state
to standing.
Any relationship between these concepts must be introduced explicitly.
-/
axiom role_not_standing :
  ¬ (∀ (a : Agent) (s : State),
       RoleState a s → StandingMeasure a s)

end SigmaR

/-!
## Interpretation

This prevents downstream users from assuming that:
- institutional position confers recognition
- roles substitute for standing
- admissibility collapses into role assignment

Role occupancy and standing are distinct structural facts.
-/

