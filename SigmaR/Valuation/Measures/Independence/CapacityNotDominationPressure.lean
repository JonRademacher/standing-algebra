import StandingAlgebra_FormalCore
import CapacityMeasure_Definition
import DominationPressure_Definition

/-!
###############################################################################
# Capacity ≠ Domination Pressure
###############################################################################

Capacity is an agent-level valuation.

Domination pressure is a system-level collapse diagnostic.

They must remain definitionally distinct.
###############################################################################
-/

axiom CapacityNotDominationPressure :
  ∀ (a : Agent) (s : State),
    CapacityMeasure a s ≠ DominationPressure s
