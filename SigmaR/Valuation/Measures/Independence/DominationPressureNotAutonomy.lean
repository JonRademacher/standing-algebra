import StandingAlgebra_FormalCore
import DominationPressure_Definition
import AutonomyMeasure_Definition

/-!
###############################################################################
# Domination Pressure ≠ Autonomy
###############################################################################

Autonomy is an agent-level valuation describing freedom
from coercive constraint.

Domination pressure is a system-level diagnostic indicating
approach to structural collapse.

They are not definitionally reducible.
###############################################################################
-/

axiom DominationPressureNotAutonomy :
  ∀ (a : Agent) (s : State),
    DominationPressure s ≠ AutonomyMeasure a s
