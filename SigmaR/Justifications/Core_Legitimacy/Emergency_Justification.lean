import SigmaR.Justifications.Core_Legitimacy.STC5_Justification

/-!
###############################################################################
# Justification of Emergency Intervention
###############################################################################

Standing Algebra permits the temporary suspension of certain normal admissibility
constraints in the presence of an urgent, externally validated crisis.
Emergency intervention is therefore a *bounded legitimacy‑suspending condition*:
it does not replace legitimacy, but temporarily relaxes some of its gates while
remaining subject to termination and repair.

From *On Relevance*:
  • External correction is justified only under validated harm.
  • In a bona fide emergency, some autonomy constraints may be relaxed,
    provided the intervention is authorized, bounded, and terminable.
  • Emergency powers must not harden into structural domination.

This file introduces predicates that capture:
  • when emergency conditions obtain, and
  • when emergency intervention is permitted.

The normative requirement is that legitimacy implies that any emergency
intervention is itself permitted wherever the emergency condition holds.
-/

namespace SigmaR

/-- Predicate: emergency conditions obtain for operation `F` at state `s`.
    This abstracts over triggers such as imminent harm, loss of viability,
    or systemic collapse. -/
constant EmergencyCondition : Operation → State → Prop

/-- Predicate: emergency intervention is permitted for operation `F` at state `s`.
    Even under emergency, intervention must remain bounded, contestable,
    and subject to repair and termination. -/
constant EmergencyPermitted : Operation → State → Prop

/--
Tier‑2 legitimacy axiom for Emergency:

If an operation is Legitimate, then whenever emergency conditions obtain,
emergency intervention must be permitted.
-/
axiom emergency_condition_implies_permitted :
  ∀ {F : Operation},
    Legitimate F →
      ∀ s : State,
        EmergencyCondition F s → EmergencyPermitted F s

/--
Derived theorem:

A legitimate operation that is in emergency conditions everywhere
must be permitted everywhere.
-/
theorem Emergency_required_for_legitimacy
  {F : Operation}
  (hLeg : Legitimate F)
  (hEmer : ∀ s : State, EmergencyCondition F s) :
  ∀ s : State, EmergencyPermitted F s :=
by
  intro s
  exact emergency_condition_implies_permitted hLeg s (hEmer s)

end SigmaR
