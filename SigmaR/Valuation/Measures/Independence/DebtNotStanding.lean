import StandingAlgebra_FormalCore
import StructuralDebt_Definition
import StandingMeasure_Definition

/-!
###############################################################################
# Structural Debt ≠ Standing
###############################################################################

Structural debt tracks unresolved asymmetry and deferred repair.

Standing tracks recognition and admissible participation.

Accumulated debt does not by itself eliminate standing,
and standing does not erase debt.
###############################################################################
-/

axiom DebtNotStanding :
  ∀ (a : Agent) (s : State),
    StructuralDebt a ≠ StandingMeasure a s
