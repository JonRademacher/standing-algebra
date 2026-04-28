import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Measures.RiskLoad_Definition
import SigmaR.Standing.ConsentState_Definition

/-!
###############################################################################
# Independence: Risk Not Consent
###############################################################################

This file establishes that risk exposure does not entail
the absence of consent.

Risk load captures exposure to harm or uncertainty.
Consent is an agent-level descriptor of voluntary participation.

Importing this file explicitly rejects any assumption that
risk exposure negates consent.
###############################################################################
-/

namespace SigmaR

/--
There is no general implication from risk load
to the absence of consent.
Any relationship between these concepts must be introduced explicitly.
-/
axiom risk_not_consent :
  ¬ (∀ (a : Agent) (s : State),
       RiskLoad a s → ¬ ConsentState a s)

end SigmaR

/-!
## Interpretation

This prevents downstream users from assuming that:
- danger invalidates agreement
- exposure implies coercion by definition
- consent collapses into safety conditions

Risk and consent are distinct structural facts.
-/
