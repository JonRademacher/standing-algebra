import StandingAlgebra_FormalCore
import StandingMeasure_Definition
import ExitViability_Definition

/-!
###############################################################################
# Standing ≠ Exit
###############################################################################

Standing concerns recognition and admissibility.

Exit viability concerns refusal and non-coercion.

Standing does not guarantee exit, and exit does not
constitute standing.
###############################################################################
-/

axiom StandingNotExit :
  ∀ (a : Agent) (s : State),
    StandingMeasure a s ≠ (if ExitViable a s then 1 else 0)
