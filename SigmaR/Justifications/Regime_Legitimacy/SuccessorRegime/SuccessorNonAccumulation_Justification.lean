import SigmaR.Justifications.Core_Legitimacy.Rerunnability_Justification
import SigmaR.Justifications.Regimes.SuccessorRegime.SuccessorRegime_Justification

/-!
###############################################################################
# Successor Non-Accumulation Justification
###############################################################################

Successor operations in Σᴿ must not ratchet standing.

From Standing Algebra:

  • Successor operations introduce structural advancement.
  • Repeated application of successor operations
    must not accumulate unbounded advantage.
  • Rerunnability blocks successor ratcheting.

Therefore:

  Legitimate successor operations must be non-accumulative
  under repetition.
###############################################################################
-/

namespace SigmaR

/--
Predicate: operation `F` accumulates standing
under repeated application.
-/
constant SuccessorAccumulates : Operation → Prop

/--
Tier-2 legitimacy axiom (Successor Non-Accumulation):

If an operation is Legitimate and is a successor operation,
then it must not accumulate standing under repetition.
-/
axiom successor_non_accumulative :
  ∀ {F : Operation},
    Legitimate F →
    SuccessorOp F →
    ¬ SuccessorAccumulates F

/--
Derived theorem:

Legitimate successor operations do not accumulate standing.
-/
theorem SuccessorNonAccumulating
  {F : Operation}
  (hLeg : Legitimate F)
  (hSucc : SuccessorOp F) :
  ¬ SuccessorAccumulates F :=
by
  exact successor_non_accumulative hLeg hSucc

end SigmaR
