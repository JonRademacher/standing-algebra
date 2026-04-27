import StandingAlgebra_FormalCore
import TemporalAccumulation_Definition
import ConsentState_Definition

/-!
###############################################################################
# Temporal Accumulation ≠ Consent
###############################################################################

Consent reflects voluntary participation at a state.

Temporal accumulation reflects irreversible structural
constraint across states.

Consent does not prevent long-term accumulation, and
accumulation does not negate consent.
###############################################################################
-/

axiom TemporalAccumulationNotConsent :
  ∀ (a : Agent) (s : State),
    TemporalAccumulation a s ≠ (if ConsentState a s then 1 else 0)
