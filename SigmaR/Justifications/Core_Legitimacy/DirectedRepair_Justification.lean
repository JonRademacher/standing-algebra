module SigmaR.Justifications.Core_Legitimacy.DirectedRepair_Justification

import SigmaR.Justifications.Core_Legitimacy.ALRP_Justification
import SigmaR.Justifications.Core_Legitimacy.CIA_Justification

/-!
###############################################################################
# Justification of Directed Repair
###############################################################################

Structural harm may arise without culpability.

Standing Algebra requires that repair operations move the system toward:
  • restored standing,
  • reduced dependency,
  • or reduced domination pressure.

From *On Relevance*:

  • Correction is justified only to neutralize validated harm.
  • Correction must not entrench autonomy loss.
  • Retributive or stabilizing coercion collapses legitimacy.

Therefore:

Repair is legitimate only when it is *directional*:
it must improve autonomy or reduce dependency.

This file introduces DirectedRepair as a Tier‑2 legitimacy
requirement on repair operations.
-/

namespace SigmaR

/--
Predicate: the operation is a repair step that moves the system toward:

  • restored standing, or
  • reduced dependency, or
  • improved CIA‑indexed autonomy.
-/
constant DirectedRepair : Operation → State → Prop

/--
Tier‑2 legitimacy axiom:

If an operation is Legitimate and serves as repair,
then at every state it must be directionally restorative.
-/
axiom directed_repair_required_for_legitimacy :
  ∀ {F : Operation},
    Legitimate F →
      ∀ s : State,
        DirectedRepair F s

/--
Derived theorem:

Legitimacy implies repair is directional.
-/
theorem DirectedRepair_required_for_legitimacy
  {F : Operation}
  (hLeg : Legitimate F) :
  ∀ s : State,
    DirectedRepair F s :=
by
  exact directed_repair_required_for_legitimacy hLeg

end SigmaR
