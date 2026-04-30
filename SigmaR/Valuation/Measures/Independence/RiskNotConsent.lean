import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Core.StructuralInterfaces
import SigmaR.Valuation.Measures.RiskLoad_Definition
import SigmaR.Standing.ConsentState_Definition

/-!
###############################################################################
# Independence: Risk Not Consent
###############################################################################

Risk exposure does not license or imply the absence of consent.

Risk load captures exposure to harm or uncertainty.
Consent is an agent-level descriptor of voluntary participation.

No default implication from risk exposure to consent
invalidation is licensed.
###############################################################################
-/

namespace SigmaR

/--
No implication treating risk exposure as negating,
invalidating, or licensing the absence of consent
is permitted.
-/
axiom risk_not_consent :
  ¬ (
    ∀ (a : Agent) (s : State),
      TreatedAsConsentInvalidFromRiskLoad a s
  )

end SigmaR
