module SigmaR.Justifications.Regime_Legitimacy.RiskRegime.RiskSensitiveSymmetry_Justification

import SigmaR.Justifications.Core_Legitimacy.CIA_Justification
import SigmaR.Justifications.Core_Legitimacy.StructuralDebt_Justification
import SigmaR.Justifications.Core_Legitimacy.DirectedRepair_Justification

/-!
###############################################################################
# Justification of Risk‑Sensitive Symmetry
###############################################################################

The Risk Regime permits standing‑weighted intervention
based on autonomy‑relevant exposure.

From *Standing Algebra*:

  • STC‑5 symmetry may be refined under risk.
  • Equal intervention is not always non‑dominating.
  • Risk‑sensitive symmetry permits asymmetrical
    intervention based on standing or exposure.

From *On Relevance*:

  • IEW may concentrate unevenly across agents.
  • Intervention may therefore scale asymmetrically.
  • However, asymmetry must not stabilize
    into persistent standing loss.

Risk‑Sensitive intervention introduces a pathway:

  Intervene₁(A)
  Intervene₂(A)
  Intervene₃(A)
  ...

which could:

  • repeatedly burden high‑risk agents,
  • suppress CIA asymmetrically,
  • or stabilize reduced autonomy

while preserving procedural legitimacy.

At the justification layer we therefore require:

  Any legitimate risk‑sensitive intervention
  that alters CIA‑indexed autonomy asymmetrically
  across agents must incur structural debt
  and therefore require directional repair.

This ensures that standing‑weighted symmetry
cannot introduce a legitimacy‑preserving
proxy optimization channel.
-/

namespace SigmaR

/-- Predicate: the operation performs risk‑sensitive
    asymmetrical intervention at state `s`. -/
constant RiskSensitiveSymmetry : Operation → State → Prop

/--
Tier‑2 legitimacy axiom for Risk‑Sensitive Symmetry:

If an operation is Legitimate and performs
risk‑sensitive asymmetrical intervention
that alters CIA‑indexed autonomy,
then structural debt must obtain.
-/
axiom risk_sensitive_symmetry_requires_debt :
  ∀ {F : Operation},
    Legitimate F →
      ∀ s : State,
        RiskSensitiveSymmetry F s →
        StructuralDebt F s

/--
Derived theorem:

Legitimacy implies that risk‑sensitive
intervention generates structural debt.
-/
theorem RiskSensitiveSymmetry_requires_debt
  {F : Operation}
  (hLeg : Legitimate F) :
  ∀ s : State,
    RiskSensitiveSymmetry F s →
    StructuralDebt F s :=
by
  intros s hRisk
  exact risk_sensitive_symmetry_requires_debt hLeg s hRisk

end SigmaR
