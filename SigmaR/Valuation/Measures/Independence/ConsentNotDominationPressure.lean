import StandingAlgebra_FormalCore
import ConsentState_Definition
import DominationPressure_Definition

/-!
###############################################################################
# Consent ≠ Domination Pressure
###############################################################################

Consented participation does not prevent the accumulation
of domination pressure, and domination pressure does not
imply absence of consent.

Domination pressure is a system-level diagnostic.
###############################################################################
-/

axiom ConsentNotDominationPressure :
  ∀ (a : Agent) (s : State),
    (if ConsentState a s then 1 else 0) ≠ DominationPressure s
