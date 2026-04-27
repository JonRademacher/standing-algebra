import StandingAlgebra_FormalCore
import TemporalAccumulation_Definition
import CapacityMeasure_Definition

/-!
###############################################################################
# Temporal Accumulation ≠ Capacity
###############################################################################

Temporal accumulation captures irreversible constraint
over time.

Capacity captures present ability or potential.

Irreversible harm may accumulate without reducing
capacity, and capacity may be constrained without
irreversible accumulation.
###############################################################################
-/

axiom TemporalAccumulationNotCapacity :
  ∀ (a : Agent) (s : State),
    TemporalAccumulation a s ≠ CapacityMeasure a s
