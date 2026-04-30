module SigmaR.Justifications.Core_Legitimacy.AlternativesConsidered_Justification

import SigmaR.Justifications.Core_Legitimacy.STC5_Justification

/-!
###############################################################################
# Justification of Alternatives Considered
###############################################################################

Legitimate coercion requires that less autonomy‑reducing alternatives
be evaluated prior to corrective intervention.

From *On Relevance*:

  • External correction is justified only where autonomy has already
    been compromised or where a validated threat outweighs autonomy cost.

This presupposes that alternative responses insufficient to neutralize
validated harm have been considered.

Standing Algebra's NRPP requires the least autonomy‑reducing means
compatible with neutralizing harm. This requirement is vacuous unless
candidate alternatives have been evaluated.

Therefore:

  Legitimate F → AlternativesConsidered F s

at every state s.
-/

namespace SigmaR

/--
Predicate: the operation has considered less autonomy‑reducing alternatives
at the given state.

This captures that coercive intervention is not applied prematurely
without evaluating viable non‑coercive responses.
-/
constant AlternativesConsidered : Operation → State → Prop

/--
Tier‑2 legitimacy axiom:

If an operation is Legitimate, then at every state it must
have evaluated less autonomy‑reducing alternatives.
-/
axiom alternatives_required_for_legitimacy :
  ∀ {F : Operation},
    Legitimate F →
      ∀ s : State,
        AlternativesConsidered F s

/--
Derived theorem:

Legitimacy implies alternatives have been considered.
-/
theorem AlternativesConsidered_required_for_legitimacy
  {F : Operation}
  (hLeg : Legitimate F) :
  ∀ s : State,
    AlternativesConsidered F s :=
by
  exact alternatives_required_for_legitimacy hLeg

end SigmaR
