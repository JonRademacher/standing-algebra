module SigmaR.Justifications.Core_Legitimacy.NonParochialEvidence_Justification

import SigmaR.Justifications.Core_Legitimacy.STC5_Justification

/-!
###############################################################################
# Justification of Non‑Parochial Evidence
###############################################################################

Legitimate coercion must not rely solely on epistemic standards that are valid
only within a particular perceptual frame or community of interpretation.

From *On Relevance*:

  • Evidence must bind across plural public groups.
  • Authorization must be rerunnable by those subject to coercion.
  • Claims that depend on privileged access or parochial framing collapse
    legitimacy in pluralist systems.

Standing Algebra requires that admissible operations remain publicly
contestable and corrigible. This entails that evidence supporting coercion
must be legible and evaluable across perceptual frame boundaries.

We therefore introduce the NonParochialEvidence predicate as a Tier‑2
legitimacy condition: any Legitimate operation must satisfy it at every state.
-/

namespace SigmaR

/--
Predicate: the operation is supported by evidence that is non‑parochial
at the given state.

Non‑parochial evidence is:
  • publicly legible,
  • not restricted to a single perceptual frame,
  • rerunnable by affected agents.
-/
constant NonParochialEvidence : Operation → State → Prop

/--
Tier‑2 legitimacy axiom:

If an operation is Legitimate, then it must be supported by
non‑parochial evidence at every state.
-/
axiom nonparochial_required_for_legitimacy :
  ∀ {F : Operation},
    Legitimate F →
      ∀ s : State,
        NonParochialEvidence F s

/--
Derived theorem:

Legitimacy implies non‑parochial evidentiary support.
-/
theorem NonParochialEvidence_required_for_legitimacy
  {F : Operation}
  (hLeg : Legitimate F) :
  ∀ s : State,
    NonParochialEvidence F s :=
by
  exact nonparochial_required_for_legitimacy hLeg

end SigmaR
