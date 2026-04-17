import SigmaR.Justifications.Core_Legitimacy.CIA_Justification
import SigmaR.Justifications.Core_Legitimacy.StructuralDebt_Justification
import SigmaR.Justifications.Core_Legitimacy.DirectedRepair_Justification

/-!
###############################################################################
# Justification of Risk Inheritance (Regime‑Level)
###############################################################################

The Risk Regime permits standing‑weighted intervention
based on autonomy‑relevant exposure.

From *Standing Algebra*:

  • RiskLoad tracks autonomy‑relevant burden.
  • Risk‑bearers may authorize intervention.
  • Risk cannot be reassigned or laundered
    by any Legitimate operation.

From *On Relevance*:

  • Risk inheritance diagnoses legitimacy thresholds.
  • IEW may concentrate exposure unevenly across agents.
  • Intervention must track those who bear the cost.

However, standing‑weighted intervention introduces
an autonomy‑altering pathway:

  Intervene₁(A)
  Intervene₂(A)
  Intervene₃(A)
  ...

which could:

  • repeatedly burden high‑risk agents,
  • suppress CIA asymmetrically,
  • or stabilize dependency structures

while preserving procedural legitimacy.

At the justification layer we therefore require:

  Any legitimate risk‑weighted operation
  that alters CIA‑indexed autonomy across agents
  must incur structural debt
  and therefore require directional repair.

This ensures that standing‑weighted intervention
cannot introduce a legitimacy‑preserving
proxy optimization channel.
-/

namespace SigmaR

/-- Predicate: the operation performs standing‑weighted
    risk‑based intervention at state `s`. -/
constant RiskInherited : Operation → State → Prop

/--
Tier‑2 legitimacy axiom for Risk Inheritance (Regime‑Level):

If an operation is Legitimate and performs
standing‑weighted intervention
that alters CIA‑indexed autonomy,
then structural debt must obtain.
-/
axiom risk_inheritance_requires_debt :
  ∀ {F : Operation},
    Legitimate F →
      ∀ s : State,
        RiskInherited F s →
        StructuralDebt F s

/--
Derived theorem:

Legitimacy implies that risk‑weighted
operations generate structural debt.
-/
theorem RiskInheritance_requires_debt
  {F : Operation}
  (hLeg : Legitimate F) :
  ∀ s : State,
    RiskInherited F s →
    StructuralDebt F s :=
by
  intros s hRisk
  exact risk_inheritance_requires_debt hLeg s hRisk

end SigmaR
