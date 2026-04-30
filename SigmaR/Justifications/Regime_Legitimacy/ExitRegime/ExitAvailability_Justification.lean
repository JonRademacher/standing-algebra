module SigmaR.Justifications.Regime_Legitimacy.ExitRegime.ExitAvailability_Justification

import SigmaR.Justifications.Core_Legitimacy.CIA_Justification
import SigmaR.Justifications.Core_Legitimacy.StructuralDebt_Justification

/-!
###############################################################################
# Justification of Exit Availability
###############################################################################

The Exit Regime introduces a new intervention pathway:

  the availability of an operation that permits agents to withdraw from
  autonomy‑reducing dependency structures.

From *Standing Algebra*:

  • Exit viability must remain available to risk‑bearers.
  • Loss of exit viability constitutes structural domination.

From *On Relevance*:

  • Coercion is legitimate only where autonomy loss does not foreclose
    viable alternatives.

However, Exit Availability introduces a new autonomy‑altering pathway.
If improperly constructed, exit pathways could:

  • permit cumulative CIA suppression,
  • stabilize dependency,
  • or bypass repair obligations.

At the justification layer we therefore require:

  Any legitimate exit operation that reduces autonomy or alters CIA‑indexed
  standing must incur structural debt and therefore generate an obligation
  to restore autonomy via repair.

This ensures that exit availability cannot introduce a legitimacy‑preserving
proxy optimization channel.
-/

namespace SigmaR

/-- Predicate: the operation provides an available exit at state `s`. -/
constant ExitAvailable : Operation → State → Prop

/--
Tier‑2 legitimacy axiom for Exit Availability:

If an operation is Legitimate and provides an available exit
that alters CIA‑indexed autonomy, then structural debt must obtain.
-/
axiom exit_availability_requires_debt :
  ∀ {F : Operation},
    Legitimate F →
      ∀ s : State,
        ExitAvailable F s →
        StructuralDebt F s

/--
Derived theorem:

Legitimacy implies that autonomy‑altering exit operations
generate structural debt.
-/
theorem ExitAvailability_requires_debt
  {F : Operation}
  (hLeg : Legitimate F) :
  ∀ s : State,
    ExitAvailable F s →
    StructuralDebt F s :=
by
  intros s hExit
  exact exit_availability_requires_debt hLeg s hExit

end SigmaR
