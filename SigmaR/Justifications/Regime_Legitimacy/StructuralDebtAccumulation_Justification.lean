import SigmaR.Justifications.Core_Legitimacy.StructuralDebt_Justification
import SigmaR.Justifications.Core_Legitimacy.DirectedRepair_Justification
import SigmaR.Justifications.Core_Legitimacy.LegitimacyEnvelope_Justification

/-!
###############################################################################
# Justification of Structural Debt Accumulation (Cross‑Regime)
###############################################################################

Core Structural Debt justifies persistence of autonomy‑loss
under individual legitimate operations.

However, the Regime Layer introduces compositional pathways:

  Exit₁
  Emergency₂
  Risk₃
  Repair₄
  ...

each of which may:

  • alter CIA‑indexed autonomy,
  • generate structural debt locally,
  • and remain procedurally legitimate.

Across regime boundaries, such operations could:

  • accumulate structural debt,
  • stabilize reduced autonomy,
  • or entrench dependency

while preserving legitimacy locally.

From *Standing Algebra*:

  • StructuralDebt may be strictly reduced
    only by Repair operations.
  • Infinite admissible trajectories must
    stabilize or invoke repair.

From *On Relevance*:

  • IEW may persist across coordination layers.
  • Behavioral compliance is not autonomy restoration.
  • Structural harm generates residual obligation.

At the justification layer we therefore require:

  Any legitimate sequence of regime‑level operations
  that cumulatively alters CIA‑indexed autonomy
  must:

    • accumulate structural debt, and
    • therefore require directional repair,
      or shrink the legitimacy envelope.

This ensures that cross‑regime intervention
cannot introduce a legitimacy‑preserving
proxy optimization channel.
-/

namespace SigmaR

/-- Predicate: the operation participates in any regime
    and contributes to structural debt at state `s`. -/
constant RegimeDebtAccumulated : Operation → State → Prop

/--
Tier‑2 legitimacy axiom for Structural Debt Accumulation:

If an operation is Legitimate and participates
in regime‑level intervention
that cumulatively alters CIA‑indexed autonomy,
then structural debt must obtain.
-/
axiom structural_debt_accumulation_requires_debt :
  ∀ {F : Operation},
    Legitimate F →
      ∀ s : State,
        RegimeDebtAccumulated F s →
        StructuralDebt F s

/--
Derived theorem:

Legitimacy implies that cross‑regime
operations generate structural debt.
-/
theorem StructuralDebtAccumulation_requires_debt
  {F : Operation}
  (hLeg : Legitimate F) :
  ∀ s : State,
    RegimeDebtAccumulated F s →
    StructuralDebt F s :=
by
  intros s hDebt
  exact structural_debt_accumulation_requires_debt hLeg s hDebt

end SigmaR
