import StandingAlgebra_FormalCore
import ExitViability_Definition
import CapacityMeasure_Definition

/-!
###############################################################################
# Exit ≠ Capacity
###############################################################################

Exit viability concerns refusal and non-coercion.

Capacity concerns ability or potential.

An agent may retain capacity without exit, or exit
without capacity.
###############################################################################
-/

axiom ExitNotCapacity :
  ∀ (a : Agent) (s : State),
    (if ExitViable a s then 1 else 0) ≠ CapacityMeasure a s
