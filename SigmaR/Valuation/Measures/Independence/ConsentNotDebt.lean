import StandingAlgebra_FormalCore
import ConsentState_Definition
import StructuralDebt_Definition

/-!
###############################################################################
# Consent ≠ Structural Debt
###############################################################################

Consent does not eliminate structural debt, and
structural debt does not imply lack of consent.

Debt tracks unresolved asymmetry, not agreement.
###############################################################################
-/

axiom ConsentNotDebt :
  ∀ (a : Agent) (s : State),
    (if ConsentState a s then 1 else 0) ≠ StructuralDebt a
