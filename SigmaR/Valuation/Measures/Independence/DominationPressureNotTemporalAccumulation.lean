import StandingAlgebra_FormalCore
import DominationPressure_Definition
import TemporalAccumulation_Definition

/-!
###############################################################################
# Domination Pressure ≠ Temporal Accumulation
###############################################################################

Temporal accumulation tracks irreversible constraint
over time.

Domination pressure tracks proximity to structural
collapse.

They are related but not definitionally reducible.
###############################################################################
-/

axiom DominationPressureNotTemporalAccumulation :
  ∀ (a : Agent) (s : State),
    DominationPressure s ≠ TemporalAccumulation a s
