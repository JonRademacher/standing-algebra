import StandingAlgebra_FormalCore
import RiskLoad_Definition
import ConsentState_Definition

/-!
###############################################################################
# Risk ≠ Consent
###############################################################################

Risk exposure does not negate consent, and consent
does not eliminate risk.

They are structurally distinct valuation facts.
###############################################################################
-/

axiom RiskNotConsent :
  ∀ (a : Agent) (s : State),
    RiskLoad a s ≠ (if ConsentState a s then 1 else 0)
