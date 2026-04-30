module SigmaR.Justifications.Regime_Legitimacy.ExitRegime.ExitPreservation_Justification

import SigmaR.Justifications.Core_Legitimacy.CIA_Justification
import SigmaR.Justifications.Core_Legitimacy.StructuralDebt_Justification
import SigmaR.Justifications.Core_Legitimacy.DirectedRepair_Justification

/-!
###############################################################################
# Justification of Exit Preservation
###############################################################################

The Exit Regime introduces temporal continuation of autonomy‑restoring
withdrawal from dependency structures.

From *Standing Algebra*:

  • Exit viability must be preserved across admissible operations.
  • Loss of preserved exit constitutes entrapment.

However, preservation introduces a temporal pathway:

  Exit₁
  Exit₂
  Exit₃
  ...

which could:

  • accumulate CIA suppression,
  • stabilize reduced autonomy,
  • or maintain dependency structures

while preserving procedural legitimacy.

At the justification layer we therefore require:

  Any legitimate exit‑preserving operation that maintains altered
  CIA‑indexed autonomy across states must carry forward structural
  debt and therefore require directional repair.

This ensures that temporal preservation of exit pathways cannot
introduce legitimacy‑preserving proxy optimization.
-/

namespace SigmaR

/-- Predicate: the operation preserves an exit pathway across states. -/
constant ExitPreserved : Operation → State → Prop

/--
Tier‑2 legitimacy axiom for Exit Preservation:

If an operation is Legitimate and preserves an exit pathway
that maintains altered CIA‑indexed autonomy across states,
then structural debt must persist.
-/
axiom exit_preservation_requires_debt :
  ∀ {F : Operation},
    Legitimate F →
      ∀ s : State,
        ExitPreserved F s →
        StructuralDebt F s

/--
Derived theorem:

Legitimacy implies that exit‑preserving operations
carry forward structural debt.
-/
theorem ExitPreservation_requires_debt
  {F : Operation}
  (hLeg : Legitimate F) :
  ∀ s : State,
    ExitPreserved F s →
    StructuralDebt F s :=
by
  intros s hExit
  exact exit_preservation_requires_debt hLeg s hExit

end SigmaR
