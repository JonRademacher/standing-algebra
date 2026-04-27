import StandingAlgebra_FormalCore
import TemporalAccumulation_Definition
import DominationPressure_Definition

/-!
###############################################################################
# Temporal Accumulation ≠ Domination Pressure
###############################################################################

Temporal accumulation tracks irreversible constraint
over time.

Domination pressure tracks proximity to systemic
collapse.

They are related but not definitionally reducible.
###############################################################################
-/

axiom TemporalAccumulationNotDominationPressure :
  ∀ (a : Agent) (s : State),
    TemporalAccumulation a s ≠ DominationPressure s
