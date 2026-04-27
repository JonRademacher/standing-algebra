import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Measures.RiskLoad_Definition
import SigmaR.Standing.RoleState_Definition

/-!
###############################################################################
# Independence: Risk ≠ Role
###############################################################################

This file establishes that risk exposure does not entail
institutional role occupancy.

Risk load captures exposure to harm or uncertainty.
Role occupancy describes an institutional position or permission.

Importing this file explicitly rejects any assumption that
risk exposure assigns or determines roles.
###############################################################################
-/

namespace SigmaR

/--
There is no general implication from risk load
to role state.
Any relationship between these concepts must be introduced explicitly.
-/
axiom risk_not_role :
  ¬ (∀ (a : Agent) (s : State),
       RiskLoad a s → RoleState a s)

end SigmaR

/-!
## Interpretation

This prevents downstream users from assuming that:
- danger confers institutional authority
- exposure substitutes for role assignment
- roles collapse into risk metrics

Risk exposure and role occupancy are distinct structural facts.
-/

