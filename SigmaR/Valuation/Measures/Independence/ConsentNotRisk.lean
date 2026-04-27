import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Standing.ConsentState_Definition
import SigmaR.Valuation.Measures.RiskLoad_Definition

/-!
###############################################################################
# Independence: Consent ≠ Risk
###############################################################################

This file establishes that consent does not entail the absence
or neutralization of risk exposure.

Consent is an agent-level act or expression.
Risk load captures exposure to harm or uncertainty.
No implication from consent to risk is assumed.

Importing this file explicitly rejects any assumption that
agreement neutralizes risk exposure.
###############################################################################
-/

namespace SigmaR

/--
There is no general implication from consent to the absence of risk load.
Any relationship between these concepts must be introduced explicitly.
-/
axiom consent_not_risk :
  ¬ (∀ (a : Agent) (s : State),
       ConsentState a s → ¬ RiskLoad a s)

end SigmaR

/-!
## Interpretation

This prevents downstream users from assuming that:
- agreement eliminates danger
- consent implies safety
- participation neutralizes exposure

Risk may persist or increase despite consent.
-/

