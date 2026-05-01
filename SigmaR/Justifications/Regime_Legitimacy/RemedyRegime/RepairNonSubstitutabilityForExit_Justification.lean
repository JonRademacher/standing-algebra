import SigmaR.Justifications.Regimes.RemedyRegime.RemedyRegime_Justification
import SigmaR.Justifications.Regimes.ExitRegime.ExitRegime_Justification

/-!
###############################################################################
# Repair Non-Substitutability for Exit Justification
###############################################################################

Repair and exit serve distinct structural roles in Σᴿ.

From Standing Algebra:

  • Exit preserves autonomy by allowing withdrawal.
  • Repair preserves autonomy by correcting harm.
  • Repair cannot replace exit.
  • Treating repair as a substitute for exit
    collapses non-domination.

Therefore:

  Legitimate remedy operations may not
  block, replace, or negate exit availability.
###############################################################################
-/

namespace SigmaR

/--
Predicate: operation `F` treats repair as a substitute
for exit at state `s`.
-/
constant RepairSubstitutesExit : Operation → State → Prop

/--
Tier-2 legitimacy axiom (Repair ≠ Exit):

If an operation is Legitimate and participates in the Remedy Regime,
then repair may not substitute for exit.
-/
axiom repair_not_exit_substitute :
  ∀ {F : Operation},
    Legitimate F →
      ∀ s : State,
        RemedyRegimeOp F s →
        ¬ RepairSubstitutesExit F s

/--
Derived theorem:

Legitimate repair cannot replace exit.
-/
theorem RepairNotExitSubstitute
  {F : Operation}
  (hLeg : Legitimate F) :
  ∀ s : State,
    RemedyRegimeOp F s →
    ¬ RepairSubstitutesExit F s :=
by
  intros s hRem
  exact repair_not_exit_substitute hLeg s hRem

end SigmaR
