import StandingAlgebra_FormalCore
import ExitViability_Definition
import StandingMeasure_Definition

/-!
###############################################################################
# Exit ≠ Standing
###############################################################################

Standing tracks recognition under admissible
participation.

Exit viability tracks the ability to refuse or withdraw.

Standing does not guarantee exit, and exit does not
constitute standing.
###############################################################################
-/

axiom ExitNotStanding :
  ∀ (a : Agent) (s : State),
    (if ExitViable a s then 1 else 0) ≠ StandingMeasure a s
