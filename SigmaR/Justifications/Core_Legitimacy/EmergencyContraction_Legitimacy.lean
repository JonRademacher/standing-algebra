import SigmaR.Justifications.Core_Legitimacy.LegitimacyEnvelope_Justification

/-!
###############################################################################
# Justification of Legitimacy Contraction under Emergency Expansion
###############################################################################

From *On Relevance*:

As emergency conditions expand, the normal domain of legitimacy contracts.
Emergency does not expand legitimacy; it reduces the domain in which ordinary
legitimacy claims apply.

That is:

  • Emergency permits temporary suspension of some normal gates.
  • But increasing emergency reduces the number of states in which
    ordinary legitimacy constraints are expected to hold.
  • Legitimacy is anti‑monotone with respect to emergency expansion.

This file introduces a predicate capturing expansion of emergency conditions
across states, and formalizes the requirement that legitimacy envelopes
shrink accordingly.
-/

namespace SigmaR

/--
Predicate: the emergency context for operation `F` expands
when moving from state `s` to state `s'`.

The internal semantics of this relation are left open for
future refinement.
-/
constant EmergencyExpanded : Operation → State → State → Prop

/--
Emergency expansion contracts legitimacy:

For a legitimate operation, if emergency expands from `s`
to `s'`, then satisfaction of the legitimacy envelope at
the more emergency‑intense state `s'` implies its satisfaction
at the less emergency‑intense state `s`.
-/
theorem Emergency_expansion_shrinks_legitimacy
  {F : Operation}
  (hLeg : Legitimate F) :
  ∀ {s s' : State},
    EmergencyExpanded F s s' →
      (LegitimacyEnvelope F s' → LegitimacyEnvelope F s) :=
by
  intros s s' hExp hEnv
  exact envelope_required_for_legitimacy hLeg s

end SigmaR
