import SigmaR.Justifications.Core_Legitimacy.StructuralDebt_Justification
import SigmaR.Justifications.Core_Legitimacy.DirectedRepair_Justification

/-!
###############################################################################
# Justification of Debt Dissipation by Repair (Cross‑Regime)
###############################################################################

StructuralDebt persists under any legitimate
autonomy‑reducing intervention.

From *Standing Algebra*:

  • StructuralDebt may be strictly reduced
    only by Repair operations.

From *On Relevance*:

  • IEW generates residual obligation.
  • Behavioral compliance is not
    autonomy restoration.
  • Structural harm requires repair
    rather than constraint alone.

Across regime boundaries:

  Exit₁ → Debt
  Emergency₂ → Debt
  Risk₃ → Debt
  ...

such operations may:

  • reduce coupling locally,
  • lower behavioral exposure,
  • or restore exit superficially

while preserving procedural legitimacy.

Without constraint, such operations could:

  • reduce StructuralDebt behaviorally,
  • redistribute exposure silently,
  • or stabilize reduced autonomy

without invoking Repair.

At the justification layer we therefore require:

  Any legitimate operation that reduces
  StructuralDebt must be a Repair
  operation restoring CIA‑indexed autonomy.

This ensures that cross‑regime intervention
cannot launder structural debt
without directional repair.
-/

namespace SigmaR

/-- Predicate: the operation reduces StructuralDebt
    at state `s`. -/
constant DebtReduced : Operation → State → Prop

/-- Predicate: the operation is a Repair operation
    restoring CIA‑indexed autonomy. -/
constant RepairOp : Operation → State → Prop

/--
Tier‑2 legitimacy axiom for Debt Dissipation:

If an operation is Legitimate and reduces
StructuralDebt, then it must be a Repair operation.
-/
axiom debt_dissipation_requires_repair :
  ∀ {F : Operation},
    Legitimate F →
      ∀ s : State,
        DebtReduced F s →
        RepairOp F s

/--
Derived theorem:

Legitimacy implies that debt reduction
requires Repair.
-/
theorem DebtDissipation_requires_repair
  {F : Operation}
  (hLeg : Legitimate F) :
  ∀ s : State,
    DebtReduced F s →
    RepairOp F s :=
by
  intros s hDebt
  exact debt_dissipation_requires_repair hLeg s hDebt

end SigmaR
