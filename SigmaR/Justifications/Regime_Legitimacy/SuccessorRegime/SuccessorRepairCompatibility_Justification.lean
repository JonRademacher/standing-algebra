import SigmaR.Justifications.Core_Legitimacy.DirectedRepair_Justification
import SigmaR.Justifications.Regimes.SuccessorRegime.SuccessorRegime_Justification

/-!
###############################################################################
# Successor Repair Compatibility Justification
###############################################################################

Successor operations in Σᴿ must remain compatible with repair.

From Standing Algebra:

  • Successor advancement must not foreclose correction.
  • Repair is required when standing-relevant harm occurs.
  • Successor operations that block repair
    reintroduce domination.

Therefore:

  Legitimate successor operations must preserve
  the availability and effectiveness of repair.
###############################################################################
-/

namespace SigmaR

/--
Predicate: operation `F` interferes with
directed repair at state `s`.
-/
constant SuccessorBlocksRepair : Operation → State → Prop

/--
Tier-2 legitimacy axiom (Successor–Repair Compatibility):

If an operation is Legitimate and is a successor operation,
then it must not block directed repair.
-/
axiom successor_repair_compatible :
  ∀ {F : Operation},
    Legitimate F →
      ∀ s : State,
        SuccessorOp F s →
        ¬ SuccessorBlocksRepair F s

/--
Derived theorem:

Legitimate successor operations preserve repair compatibility.
-/
theorem SuccessorRepairCompatible
  {F : Operation}
  (hLeg : Legitimate F) :
  ∀ s : State,
    SuccessorOp F s →
    ¬ SuccessorBlocksRepair F s :=
by
  intros s hSucc
  exact successor_repair_compatible hLeg s hSucc

end SigmaR
