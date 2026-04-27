import StandingAlgebra_FormalCore
import DominationPressure_Definition
import ConsentState_Definition

/-!
###############################################################################
# Domination Pressure ≠ Consent
###############################################################################

Domination pressure is a system-level diagnostic of
structural instability.

Consent is an agent-level descriptor of voluntary
participation.

Systemic domination may arise despite consent, and
consent does not negate domination pressure.
###############################################################################
-/

axiom DominationPressureNotConsent :
  ∀ (a : Agent) (s : State),
    DominationPressure s ≠ (if ConsentState a s then 1 else 0)
