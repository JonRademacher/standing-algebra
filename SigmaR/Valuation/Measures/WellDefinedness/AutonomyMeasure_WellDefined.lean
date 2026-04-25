import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Measures.AutonomyMeasure_Definition

/-!
###############################################################################
# Autonomy Measure — Well-Definedness
###############################################################################

Ensures that autonomy is a total, non-negative
valuation quantity for all agents and states.

No monotonicity or admissibility properties
are asserted here.
###############################################################################
-/

namespace SigmaR

/--
AutonomyMeasure is well-defined if it yields
a natural number for every agent in every state.
-/
def AutonomyMeasure_WellDefined : Prop :=
  ∀ (a : Agent) (s : State), ∃ (n : Nat), AutonomyMeasure a s = n

end SigmaR
