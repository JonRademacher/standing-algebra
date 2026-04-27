import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Standing.RoleState_Definition
import SigmaR.Valuation.Measures.DominationPressure_Definition

/-!
###############################################################################
# Independence: Role ≠ Domination Pressure
###############################################################################

This file establishes that institutional role occupancy does not
entail domination pressure.

Roles are institutional descriptors of position or permission.
Domination pressure is a system-level diagnostic of structural
instability or approach to collapse.

Importing this file explicitly rejects any assumption that
holding a role determines or mitigates domination pressure.
###############################################################################
-/

namespace SigmaR

/--
There is no general implication from role state
to domination pressure.
Any relationship between these concepts must be introduced explicitly.
-/
axiom role_not_domination_pressure :
  ¬ (∀ (a : Agent) (s : State),
       RoleState a s → DominationPressure s)

end SigmaR

/-!
## Interpretation

This prevents downstream users from assuming that:
- institutional position prevents domination
- roles stabilize systemic collapse
- domination pressure collapses into role assignment

Roles and domination pressure are distinct structural facts.
-/
