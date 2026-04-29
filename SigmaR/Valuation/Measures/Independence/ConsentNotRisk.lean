import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Core.StructuralInterfaces
import SigmaR.Standing.ConsentState_Definition
import SigmaR.Valuation.Measures.RiskLoad_Definition

/-!
###############################################################################
# Independence: Consent Not Risk
###############################################################################

Consent is an agent-level act or expression.
Risk load captures exposure to harm or uncertainty.

No default implication from consent to the absence
or neutralization of risk is licensed.
###############################################################################
-/

namespace SigmaR

/--
No implication treating consent as eliminating,
neutralizing, or licensing the absence of risk load
is permitted.
-/
axiom consent_not_risk :
  ¬ (
    ∀ (a : Agent) (s : State),
      TreatedAsRiskResolvedFromConsentState a s
  )

end SigmaR
