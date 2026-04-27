import StandingAlgebra_FormalCore
import CapacityMeasure_Definition
import TemporalAccumulation_Definition

/-!
###############################################################################
# Capacity ≠ Temporal Accumulation
###############################################################################

Capacity measures present ability or potential.

Temporal accumulation measures irreversible constraint
over time.

They are not definitionally reducible.
###############################################################################
-/

axiom CapacityNotTemporalAccumulation :
  ∀ (a : Agent) (s : State),
    CapacityMeasure a s ≠ TemporalAccumulation a s
