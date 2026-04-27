import StandingAlgebra_FormalCore
import DominationPressure_Definition
import CapacityMeasure_Definition

/-!
###############################################################################
# Domination Pressure ≠ Capacity
###############################################################################

Capacity measures agent ability or potential.

Domination pressure measures systemic instability.

System-level collapse diagnostics must not substitute
for agent-level capacity.
###############################################################################
-/

axiom DominationPressureNotCapacity :
  ∀ (a : Agent) (s : State),
    DominationPressure s ≠ CapacityMeasure a s
