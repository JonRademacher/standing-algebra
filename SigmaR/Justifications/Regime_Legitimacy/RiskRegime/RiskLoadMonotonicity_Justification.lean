import SigmaR.Justifications.Core_Legitimacy.CIA_Justification
import SigmaR.Justifications.Core_Legitimacy.StructuralDebt_Justification
import SigmaR.Justifications.Core_Legitimacy.DirectedRepair_Justification

/-!
###############################################################################
# Justification of Risk Load Monotonicity
###############################################################################

The Risk Regime permits standing‑weighted intervention
based on autonomy‑relevant exposure.

From *Standing Algebra*:

  • RiskLoad tracks autonomy‑relevant burden.
  • RiskLoad may be strictly reduced
    only by Repair operations.
  • Legitimate operations may not
    reduce structural exposure
    without invoking repair.

From *On Relevance*:

  • IEW may increase exposure unevenly.
  • Intervention may reduce behavioral risk
    without restoring autonomy.
  • Behavioral compliance is not
    autonomy restoration.

Risk‑weighted intervention therefore introduces:

  Intervene₁(A)
  Intervene₂(A)
  Intervene₃(A)
  ...

which could:

  • reduce coupling locally,
  • suppress CIA cumulatively,
  • or stabilize dependency

while preserving procedural legitimacy.

At the justification layer we therefore require:

  Any legitimate risk‑weighted operation
  that reduces autonomy‑relevant exposure
  without restoring CIA‑indexed autonomy
  must incur structural debt
  and therefore require directional repair.

This ensures that RiskLoad reduction
cannot introduce a legitimacy‑preserving
proxy optimization channel.
-/

namespace SigmaR

/-- Predicate: the operation reduces RiskLoad
    without restoring CIA‑indexed autonomy at state `s`. -/
constant RiskLoadReduced : Operation → State → Prop

/--
Tier‑2 legitimacy axiom for Risk Load Monotonicity:

If an operation is Legitimate and reduces
autonomy‑relevant exposure
without restoring CIA‑indexed autonomy,
then structural debt must obtain.
-/
axiom risk_load_monotonicity_requires_debt :
  ∀ {F : Operation},
    Legitimate F →
      ∀ s : State,
        RiskLoadReduced F s →
        StructuralDebt F s

/--
Derived theorem:

Legitimacy implies that risk‑load‑reducing
operations generate structural debt.
-/
theorem RiskLoadMonotonicity_requires_debt
  {F : Operation}
  (hLeg : Legitimate F) :
  ∀ s : State,
    RiskLoadReduced F s →
    StructuralDebt F s :=
by
  intros s hRisk
  exact risk_load_monotonicity_requires_debt hLeg s hRisk

end SigmaR
