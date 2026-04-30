module SigmaR.Justifications.Regime_Legitimacy.SuccessorRegime.SuccessorConsistency_Justification

import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Justifications.Regimes.SuccessorRegime.SuccessorRegime_Justification

/-!
###############################################################################
# Successor Consistency Justification
###############################################################################

Standing Algebra is successor-native.

From Standing Algebra:

  • Standing change is discrete and successor-bounded.
  • Legitimate operations may only preserve standing
    or increment it by exactly one successor step.
  • No subtraction, skipping, or fractional change
    is admissible.

Allowing multi-step or non-successor change would
reintroduce aggregation, optimization, or domination.

Therefore:

  Successor-consistent change is required
  for legitimacy.
###############################################################################
-/

namespace SigmaR

/--
Predicate: operation `F` is successor-consistent
with respect to standing.
-/
constant SuccessorConsistent : Operation → Prop

/--
Tier-2 legitimacy axiom (Successor Consistency):

Legitimate operations must be successor-consistent.
-/
axiom successor_consistency_required :
  ∀ {F : Operation},
    Legitimate F →
    SuccessorConsistent F

/--
Derived theorem:

Legitimate operations are successor-consistent.
-/
theorem SuccessorConsistency
  {F : Operation}
  (hLeg : Legitimate F) :
  SuccessorConsistent F :=
by
  exact successor_consistency_required hLeg

end SigmaR
