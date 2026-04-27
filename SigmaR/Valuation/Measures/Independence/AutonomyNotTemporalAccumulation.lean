import StandingAlgebra_FormalCore
import AutonomyMeasure_Definition
import TemporalAccumulation_Definition

/-!
###############################################################################
# Autonomy ≠ Temporal Accumulation
###############################################################################

Autonomy captures present structural freedom.

Temporal accumulation captures irreversible constraint
over time.

An agent may retain autonomy while irreversible harm
accumulates, or lose autonomy without long-term accumulation.
###############################################################################
-/

axiom AutonomyNotTemporalAccumulation :
  ∀ (a : Agent) (s : State),
    AutonomyMeasure a s ≠ TemporalAccumulation a s
