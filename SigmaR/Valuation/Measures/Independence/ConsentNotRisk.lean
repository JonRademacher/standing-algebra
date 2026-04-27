import StandingAlgebra_FormalCore
import ConsentState_Definition
import RiskLoad_Definition

/-!
###############################################################################
# Consent ≠ Risk
###############################################################################

Consent does not neutralize risk exposure, and
risk exposure does not negate consent.

They are structurally distinct.
###############################################################################
-/

axiom ConsentNotRisk :
  ∀ (a : Agent) (s : State),
    (if ConsentState a s then 1 else 0) ≠ RiskLoad a s
