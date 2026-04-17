import SigmaR.Justifications.Core_Legitimacy.StructuralDebt_Justification
import SigmaR.Justifications.Core_Legitimacy.DirectedRepair_Justification
import SigmaR.Justifications.Core_Legitimacy.LegitimacyEnvelope_Justification
import SigmaR.Justifications.Regimes.Exit.ExitAvailability_Justification
import SigmaR.Justifications.Regimes.Exit.ExitPreservation_Justification

/-!
###############################################################################
# Justification of Exit Regime Closure
###############################################################################

The Exit Regime permits autonomy‑restoring withdrawal from dependency
structures via operations satisfying Exit Availability and Exit Preservation.

However, the regime introduces a compositional pathway:

  Exit₁
  Exit₂
  Exit₃
  ...

which, if unconstrained, could:

  • accumulate CIA suppression,
  • stabilize reduced autonomy,
  • or maintain dependency structures

while preserving procedural legitimacy.

At the justification layer we therefore require:

  Any legitimate sequence of exit operations that alters CIA‑indexed
  autonomy must generate structural debt and therefore require
  directional repair or shrink the legitimacy envelope.

This ensures that iterated exit operations cannot introduce a
legitimacy‑preserving proxy optimization channel.
-/

namespace SigmaR

/-- Predicate: the operation participates in the Exit Regime at state `s`. -/
constant ExitRegimeOp : Operation → State → Prop

/--
Tier‑2 legitimacy axiom for Exit Regime Closure:

If an operation is Legitimate and belongs to the Exit Regime,
then structural debt must obtain at every state in which it applies.
-/
axiom exit_regime_requires_debt :
  ∀ {F : Operation},
    Legitimate F →
      ∀ s : State,
        ExitRegimeOp F s →
        StructuralDebt F s

/--
Derived theorem:

Legitimacy implies that exit‑regime operations
generate structural debt.
-/
theorem ExitRegime_requires_debt
  {F : Operation}
  (hLeg : Legitimate F) :
  ∀ s : State,
    ExitRegimeOp F s →
    StructuralDebt F s :=
by
  intros s hExit
  exact exit_regime_requires_debt hLeg s hExit

end SigmaR
