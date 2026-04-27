import StandingAlgebra_FormalCore
import CapacityMeasure_Definition
import ExitViability_Definition

/-!
###############################################################################
# Capacity ≠ Exit
###############################################################################

Capacity measures ability or potential.

Exit viability is a structural predicate concerning refusal
and non-coercion.

An agent may have capacity without exit, or exit without
capacity.
###############################################################################
-/

axiom CapacityNotExit :
  ∀ (a : Agent) (s : State),
    CapacityMeasure a s ≠ (if ExitViable a s then 1 else 0)
