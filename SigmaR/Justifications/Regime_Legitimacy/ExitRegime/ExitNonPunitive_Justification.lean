module SigmaR.Justifications.Regime_Legitimacy.ExitRegime.ExitNonPunitive_Justification

import SigmaR.Justifications.Core_Legitimacy.CIA_Justification
import SigmaR.Justifications.Regimes.ExitRegime.ExitRegime_Justification

/-!
###############################################################################
# Exit Non-Punitive Justification
###############################################################################

Exit in Σᴿ is a structural release valve, not a privilege.

From Standing Algebra and On Relevance:

  • Exit must not impose disproportionate penalties.
  • Exit that destroys standing, capacity, or future participation
    is functionally equivalent to no exit.
  • Treating exit as a sanction constitutes coercion.

Therefore:

  Legitimate exit must be non-punitive with respect to
  standing and capacity.
###############################################################################
-/

namespace SigmaR

/--
Predicate: exiting via operation `F` imposes a punitive burden
on agent `a` at state `s`.
-/
constant PunitiveExit : Agent → Operation → State → Prop

/--
Tier-2 legitimacy axiom (Exit Non-Punitiveness):

If an operation is Legitimate and provides exit,
then exiting agents must not incur punitive standing
or capacity loss.
-/
axiom exit_non_punitive :
  ∀ {F : Operation},
    Legitimate F →
      ∀ s : State,
        ExitRegimeOp F s →
        ∀ a : Agent,
          ¬ PunitiveExit a F s

/--
Derived theorem:

Legitimate exit cannot be punitive.
-/
theorem ExitNonPunitive
  {F : Operation}
  (hLeg : Legitimate F) :
  ∀ s : State,
    ExitRegimeOp F s →
    ∀ a : Agent,
      ¬ PunitiveExit a F s :=
by
  intros s hExit a
  exact exit_non_punitive hLeg s hExit a

end SigmaR
