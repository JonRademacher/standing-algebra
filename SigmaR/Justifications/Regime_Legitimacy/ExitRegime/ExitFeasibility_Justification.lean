import SigmaR.Justifications.Core_Legitimacy.CIA_Justification
import SigmaR.Justifications.Regimes.ExitRegime.ExitAvailability_Justification

/-!
###############################################################################
# Exit Feasibility Justification
###############################################################################

Exit in Σᴿ must be structurally feasible, not merely formal.

From Standing Algebra:

  • Exit paths that require unavailable resources,
    hostile cooperation, or impossible conditions
    are not meaningful exits.
  • Exit feasibility must respect agent capacity (CIA).

Therefore:

  Legitimate exit must be feasible for the agents
  whose standing is constrained.
###############################################################################
-/

namespace SigmaR

/--
Predicate: agent `a` has a feasible exit path
under operation `F` at state `s`.
-/
constant FeasibleExit : Agent → Operation → State → Prop

/--
Tier-2 legitimacy axiom (Exit Feasibility):

If an operation is Legitimate and provides exit,
then exit must be feasible for the agents affected,
relative to their capacity.
-/
axiom exit_must_be_feasible :
  ∀ {F : Operation},
    Legitimate F →
      ∀ s : State,
        ExitRegimeOp F s →
        ∀ a : Agent,
          FeasibleExit a F s

/--
Derived theorem:

Legitimate exit must be feasible.
-/
theorem ExitFeasible
  {F : Operation}
  (hLeg : Legitimate F) :
  ∀ s : State,
    ExitRegimeOp F s →
    ∀ a : Agent,
      FeasibleExit a F s :=
by
  intros s hExit a
  exact exit_must_be_feasible hLeg s hExit a

end SigmaR
