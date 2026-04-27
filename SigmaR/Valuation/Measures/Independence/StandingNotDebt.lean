import StandingAlgebra_FormalCore
import StandingMeasure_Definition
import StructuralDebt_Definition

/-!
###############################################################################
# Standing ≠ Structural Debt
###############################################################################

Standing tracks recognition under admissible participation.

Structural debt tracks unresolved asymmetry and deferred repair.

Accumulated debt does not eliminate standing, and standing
does not discharge debt.
###############################################################################
-/

axiom StandingNotDebt :
  ∀ (a : Agent) (s : State),
    StandingMeasure a s ≠ StructuralDebt a
