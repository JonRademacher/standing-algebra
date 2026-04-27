import StandingAlgebra_FormalCore
import StructuralDebt_Definition
import ConsentState_Definition

/-!
###############################################################################
# Structural Debt ≠ Consent
###############################################################################

Consent does not discharge structural debt, and
structural debt does not imply absence of consent.

They represent distinct structural facts.
###############################################################################
-/

axiom DebtNotConsent :
  ∀ (a : Agent) (s : State),
    StructuralDebt a ≠ (if ConsentState a s then 1 else 0)
