import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Standing.RoleState_Definition
import SigmaR.Valuation.Measures.RiskLoad_Definition

/-!
###############################################################################
# Independence: Role ≠ Risk
###############################################################################

This file establishes that institutional role occupancy does not
entail risk exposure.

Roles are institutional descriptors of position or permission.
Risk load captures inherited or situational exposure to harm.

Importing this file explicitly rejects any assumption that
holding an institutional role determines risk exposure.
###############################################################################
-/

namespace SigmaR

/--
There is no general implication from role state
to risk load.
Any relationship between these concepts must be introduced explicitly.
-/
axiom role_not_risk :
  ¬ (∀ (a : Agent) (s : State),
       RoleState a s → RiskLoad a s)

end SigmaR

/-!
## Interpretation

This prevents downstream users from assuming that:
- institutional position implies exposure
- roles substitute for risk assessment
- risk collapses into role assignment

Role occupancy and risk exposure are distinct structural facts.
-/

