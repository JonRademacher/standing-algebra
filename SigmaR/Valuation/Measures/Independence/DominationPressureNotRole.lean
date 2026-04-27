import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Measures.DominationPressure_Definition
import SigmaR.Standing.RoleState_Definition

/-!
###############################################################################
# Independence: Domination Pressure ≠ Role
###############################################################################

This file establishes that domination pressure does not entail
institutional role occupancy.

Role occupancy is an institutional descriptor of position or permission.
Domination pressure is a system-level diagnostic of structural instability
or approach to collapse.

Importing this file explicitly rejects any assumption that
systemic domination pressure assigns or determines roles.
###############################################################################
-/

namespace SigmaR

/--
There is no general implication from domination pressure
to role state.
Any relationship between these concepts must be introduced explicitly.
-/
axiom domination_pressure_not_role :
  ¬ (∀ (a : Agent) (s : State),
       DominationPressure s → RoleState a s)

end SigmaR

/-!
## Interpretation

This prevents downstream users from assuming that:
- systemic instability confers institutional position
- domination pressure assigns authority or office
- roles collapse into collapse diagnostics

Roles are assigned; domination pressure is diagnosed.
-/

