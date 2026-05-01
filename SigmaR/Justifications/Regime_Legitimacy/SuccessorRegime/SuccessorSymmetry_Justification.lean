import SigmaR.Justifications.Core_Legitimacy.STC5_Justification
import SigmaR.Justifications.Regimes.SuccessorRegime.SuccessorRegime_Justification

/-!
###############################################################################
# Successor Symmetry Justification
###############################################################################

Successor operations in Σᴿ must respect standing symmetry.

From Standing Algebra:

  • Successor generation increases or extends standing.
  • Any asymmetry in successor treatment constitutes
    covert privilege or selection.
  • Successor operations must therefore preserve STC-5 symmetry.

Therefore:

  Legitimate successor operations must treat
  symmetry-equivalent agents symmetrically.
###############################################################################
-/

namespace SigmaR

/--
Predicate: operation `F` is a successor-generating operation
at state `s`.
-/
constant SuccessorOp : Operation → State → Prop

/--
Tier-2 legitimacy axiom (Successor Symmetry):

If an operation is Legitimate and is a successor operation,
then it must preserve standing symmetry.
-/
axiom successor_symmetry_required :
  ∀ {F : Operation},
    Legitimate F →
      ∀ s : State,
        SuccessorOp F s →
        STC5 F

/--
Derived theorem:

Legitimate successor operations preserve symmetry.
-/
theorem SuccessorPreservesSymmetry
  {F : Operation}
  (hLeg : Legitimate F) :
  ∀ s : State,
    SuccessorOp F s →
    STC5 F :=
by
  intros s hSucc
  exact successor_symmetry_required hLeg s hSucc

end SigmaR
