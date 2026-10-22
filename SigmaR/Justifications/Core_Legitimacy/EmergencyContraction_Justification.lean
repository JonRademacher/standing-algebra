import SigmaR.Justifications.Core_Legitimacy.LegitimacyEnvelope_Justifrication
import SigmaR.Justifications.Core_Legitimacy.StructuralDebt_Justification
import SigmaR.Justifications.Regime_Legitimacy.EmergencyRegime.EmergencyRegime_Justification

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
axiom EmergencyExpanded : Operation → State → State → Prop

/-- The operation contracts its emergency-driven structural impact. -/
axiom EmergencyContraction : Operation → State → Prop

/-- Emergency contraction required when a legitimate emergency operation
incurs structural debt. -/
axiom legitimate_emergency_requires_contraction :
  ∀ {F : Operation} {s : State},
    Legitimate F →
    EmergencyRegimeOp F s →
    HasStructuralDebt F s →
    EmergencyContraction F s

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

/-- A legitimate emergency operation carrying debt must contract it. -/
theorem EmergencyContraction_required_for_legitimacy
  {F : Operation} {s : State}
  (hLeg : Legitimate F)
  (hEmer : EmergencyRegimeOp F s)
  (hDebt : HasStructuralDebt F s) :
  EmergencyContraction F s :=
legitimate_emergency_requires_contraction hLeg hEmer hDebt

end SigmaR
