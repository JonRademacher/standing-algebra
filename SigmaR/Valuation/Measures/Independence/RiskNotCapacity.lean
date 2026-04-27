import StandingAlgebra_FormalCore
import RiskLoad_Definition
import CapacityMeasure_Definition

/-!
###############################################################################
# Risk ≠ Capacity
###############################################################################

Risk load measures inherited exposure.

Capacity measures agent ability or potential.

Risk may increase without reducing capacity, and capacity
may be constrained without increased risk.
###############################################################################
-/

axiom RiskNotCapacity :
  ∀ (a : Agent) (s : State),
    RiskLoad a s ≠ CapacityMeasure a s
