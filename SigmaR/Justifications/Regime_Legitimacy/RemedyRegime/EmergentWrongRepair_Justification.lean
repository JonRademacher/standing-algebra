module SigmaR.Justifications.Regime_Legitimacy.RemedyRegime.EmergentWrongRepair_Justification

import SigmaR.Justifications.Core_Legitimacy.CIA_Justification
import SigmaR.Justifications.Core_Legitimacy.StructuralDebt_Justification
import SigmaR.Justifications.Core_Legitimacy.DirectedRepair_Justification

/-!
###############################################################################
# Justification of Independently Emergent Wrong (IEW) Repair
###############################################################################

In *On Relevance*, Independently Emergent Wrong (IEW) refers to structural
autonomy‑loss arising from system‑level coupling rather than agent culpability.

IEW occurs where:

  • interactions between agents and institutions produce autonomy loss
    without desert or blame;
  • dependency structures arise from emergent system behavior;
  • harm is a function of configuration rather than intent.

Standing Algebra therefore permits corrective intervention in response to
IEW, even absent wrongdoing, provided that:

  • harm has been structurally validated;
  • intervention satisfies STC‑5;
  • and correction remains autonomy‑restoring.

However, IEW‑responsive repair introduces an autonomy‑altering pathway:

  Repair₁
  Repair₂
  Repair₃
  ...

which could:

  • temporarily suppress CIA‑indexed autonomy,
  • stabilize dependency,
  • or accumulate autonomy loss

while preserving procedural legitimacy.

At the justification layer we therefore require:

  Any legitimate repair operation responding to IEW
  that alters CIA‑indexed autonomy must incur
  structural debt and therefore require
  directional repair.

This ensures that IEW‑responsive remedy cannot:

  • stabilize emergent autonomy loss,
  • entrench dependency,
  • or introduce a legitimacy‑preserving
    proxy optimization channel.

IEW‑repair must therefore remain
debt‑bearing and autonomy‑restorative.
-/

namespace SigmaR

/-- Predicate: an Independently Emergent Wrong is present at state `s`. -/
constant IndependentlyEmergentWrong : State → Prop

/-- Predicate: the operation performs repair in response to IEW at state `s`. -/
constant IEWRepair : Operation → State → Prop

/--
Tier‑2 legitimacy axiom for IEW Repair:

If an operation is Legitimate and performs repair in response
to an Independently Emergent Wrong that alters CIA‑indexed autonomy,
then structural debt must obtain.
-/
axiom iew_repair_requires_debt :
  ∀ {F : Operation},
    Legitimate F →
      ∀ s : State,
        IEWRepair F s →
        StructuralDebt F s

/--
Derived theorem:

Legitimacy implies that IEW‑responsive repair
generates structural debt.
-/
theorem IEWRepair_requires_debt
  {F : Operation}
  (hLeg : Legitimate F) :
  ∀ s : State,
    IEWRepair F s →
    StructuralDebt F s :=
by
  intros s hRepair
  exact iew_repair_requires_debt hLeg s hRepair

end SigmaR
