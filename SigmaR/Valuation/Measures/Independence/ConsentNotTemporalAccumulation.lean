import StandingAlgebra_FormalCore
import ConsentState_Definition
import TemporalAccumulation_Definition

/-!
###############################################################################
# Consent ≠ Temporal Accumulation
###############################################################################

Consent at a given state does not prevent irreversible
constraint from accumulating over time, and temporal
accumulation does not negate consent.

They are not definitionally reducible.
###############################################################################
-/

axiom ConsentNotTemporalAccumulation :
  ∀ (a : Agent) (s : State),
    (if ConsentState a s then 1 else 0) ≠ TemporalAccumulation a s
