import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Core.StructuralInterfaces
import SigmaR.Valuation.Measures.Definitions.ConsentState_Definition
import SigmaR.Valuation.Measures.Definitions.RiskLoad_Definition

open SigmaR.Valuation.Core

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

namespace SigmaR.Valuation.Measures.Independence

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

end SigmaR.Valuation.Measures.Independence
