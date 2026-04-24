import SigmaR.Justifications.Regimes.ExitRegime.ExitRegime_Justification
import SigmaR.Justifications.Core_Legitimacy.ContestationCondition_Justification

/-!
###############################################################################
# Exit Non-Substitutability Justification
###############################################################################

Exit in Σᴿ is not interchangeable with contestation.

From Standing Algebra and On Relevance:

  • Appeal, review, or participation mechanisms
    do not substitute for exit.
  • Exit requires the ability to withdraw from constraint,
    not merely to contest it.
  • Treating voice as exit collapses non-domination.

Therefore:

  Legitimate exit may not be replaced by internal
  contestation mechanisms.
###############################################################################
-/

namespace SigmaR

/--
Predicate: operation `F` treats contestation or appeal
as a substitute for exit at state `s`.
-/
constant ExitSubstitutedByContestation : Operation → State → Prop

/--
Tier-2 legitimacy axiom (Exit Non-Substitutability):

If an operation is Legitimate and participates in the Exit Regime,
then exit may not be substituted by contestation or appeal.
-/
axiom exit_not_substitutable :
  ∀ {F : Operation},
    Legitimate F →
      ∀ s : State,
        ExitRegimeOp F s →
        ¬ ExitSubstitutedByContestation F s

/--
Derived theorem:

Legitimate exit cannot be substituted by contestation.
-/
theorem ExitNotSubstitutable
  {F : Operation}
  (hLeg : Legitimate F) :
  ∀ s : State,
    ExitRegimeOp F s →
    ¬ ExitSubstitutedByContestation F s :=
by
  intros s hExit
  exact exit_not_substitutable hLeg s hExit

end SigmaR
