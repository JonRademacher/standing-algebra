import StandingAlgebra_FormalCore
import AutonomyMeasure_Definition
import DominationPressure_Definition

/-!
###############################################################################
# Autonomy ≠ Domination Pressure
###############################################################################

Autonomy is an agent-level valuation describing freedom
from coercive constraint.

Domination pressure is a global diagnostic of structural
instability and collapse.

They are not definitionally reducible.
###############################################################################
-/

axiom AutonomyNotDominationPressure :
  ∀ (a : Agent) (s : State),
    AutonomyMeasure a s ≠ DominationPressure s
