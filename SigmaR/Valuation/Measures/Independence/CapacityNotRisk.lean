import StandingAlgebra_FormalCore
import CapacityMeasure_Definition
import RiskLoad_Definition

/-!
###############################################################################
# Capacity ≠ Risk
###############################################################################

Capacity is not reducible to inherited risk exposure.

Risk may increase without reducing capacity, and capacity
may be constrained without increased risk.
###############################################################################
-/

axiom CapacityNotRisk :
  ∀ (a : Agent) (s : State),
    CapacityMeasure a s ≠ RiskLoad a s
