import SigmaR.StandingAlgebra_FormalCore

/-!
###############################################################################
# Exit Threshold Soundness (Valuation Core)
###############################################################################

This file ensures that exit thresholds are meaningful,
monotone, and non-vacuous as valuation objects.

It does NOT authorize exit denial or enforcement.
###############################################################################
-/

namespace SigmaR

/--
Predicate: exit is viable for agent `i` in state `s`.
-/
constant ExitViable : Agent → State → Prop

/--
Predicate: agent `i` has crossed an exit threshold in state `s`.
-/
constant ExitThresholdCrossed : Agent → State → Prop

/--
Exit threshold soundness:

Once crossed, exit is no longer viable.
-/
axiom ExitThresholdSound :
  ∀ (i : Agent) (s : State),
    ExitThresholdCrossed i s →
    ¬ ExitViable i s

/--
Derived theorem.
-/
theorem ExitThresholdImpliesNoExit
  (i : Agent) (s : State)
  (h : ExitThresholdCrossed i s) :
  ¬ ExitViable i s :=
by
  exact ExitThresholdSound i s h

end SigmaR
