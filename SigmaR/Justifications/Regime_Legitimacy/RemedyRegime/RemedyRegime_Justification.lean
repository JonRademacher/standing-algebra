module SigmaR.Justifications.Regime_Legitimacy.RemedyRegime.RemedyRegime_Justification

import SigmaR.Justifications.Core_Legitimacy.StructuralDebt_Justification
import SigmaR.Justifications.Core_Legitimacy.DirectedRepair_Justification
import SigmaR.Justifications.Core_Legitimacy.LegitimacyEnvelope_Justification
import SigmaR.Justifications.Regimes.Remedy.EmergentWrongRepair_Justification
import SigmaR.Justifications.Regimes.Remedy.RepairAvailability_Justification

/-!
###############################################################################
# Justification of Remedy Regime Closure (IEW‑Robust)
###############################################################################

The Remedy Regime permits repair operations in response to
Independently Emergent Wrong (IEW):

  • autonomy‑impairing structural harm arising without culpability.

From *Standing Algebra*:

  EmergentWrong(s) →
    ∃ R (Repair(R) ∧ ¬EmergentWrong(R(s)))

That is, repair must exist even absent blame.

From *On Relevance*:

  IEW is a structural legitimacy failure that:
    • persists without agent intent,
    • calls for repair rather than punishment,
    • and generates structural debt.

However, the Remedy Regime introduces a compositional pathway:

  Repair₁
  Repair₂
  Repair₃
  ...

which, if unconstrained, could:

  • temporarily suppress CIA‑indexed autonomy,
  • stabilize reduced standing,
  • or entrench dependency structures

while preserving procedural legitimacy.

At the justification layer we therefore require:

  Any legitimate sequence of IEW‑responsive repair operations
  that alters CIA‑indexed autonomy must:

    • generate structural debt, and
    • therefore require directional repair,
      or shrink the legitimacy envelope.

This ensures that iterated remedy cannot:

  • stabilize emergent autonomy loss,
  • normalize IEW‑induced dependency,
  • or introduce a legitimacy‑preserving
    proxy optimization channel.

Repair must remain debt‑bearing
and autonomy‑restorative under iteration.
-/

namespace SigmaR

/-- Predicate: the operation participates in the Remedy Regime at state `s`. -/
constant RemedyRegimeOp : Operation → State → Prop

/--
Tier‑2 legitimacy axiom for Remedy Regime Closure:

If an operation is Legitimate and belongs to the Remedy Regime,
then structural debt must obtain at every state in which it applies.
-/
axiom remedy_regime_requires_debt :
  ∀ {F : Operation},
    Legitimate F →
      ∀ s : State,
        RemedyRegimeOp F s →
        StructuralDebt F s

/--
Derived theorem:

Legitimacy implies that remedy‑regime operations
generate structural debt.
-/
theorem RemedyRegime_requires_debt
  {F : Operation}
  (hLeg : Legitimate F) :
  ∀ s : State,
    RemedyRegimeOp F s →
    StructuralDebt F s :=
by
  intros s hRem
  exact remedy_regime_requires_debt hLeg s hRem

end SigmaR
