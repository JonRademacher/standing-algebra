module SigmaR.Justifications.Core_Legitimacy.LegitimacyEnvelope_Justification

import SigmaR.Justifications.Core_Legitimacy.STC5_Justification
import SigmaR.Justifications.Core_Legitimacy.ALRP_Justification
import SigmaR.Justifications.Core_Legitimacy.BoundedDrift_Justification
import SigmaR.Justifications.Core_Legitimacy.RiskInheritance_Justification
import SigmaR.Justifications.Core_Legitimacy.NonParochialEvidence_Justification
import SigmaR.Justifications.Core_Legitimacy.AlternativesConsidered_Justification
import SigmaR.Justifications.Core_Legitimacy.OffRampsAndCorrection_Justification

/-!
###############################################################################
# Justification of the Legitimacy Envelope
###############################################################################

Standing Algebra introduces the notion of a *legitimacy envelope* as the
canonical aggregation of all normative constraints required for admissible,
non‑dominating coercion under pluralism.

Informally, an operation is legitimate iff it satisfies:
  • the full STC‑5 gate suite (risk inheritance & validation, non‑parochial
    evidence, NRPP fit, alternatives considered, off‑ramps & correction),
  • ALRP (no standing erosion),
  • bounded drift,
  • and any additional Tier‑2 constraints.

The Envelope Theorem (Standing Algebra §3.12 / §6.11) states that any legitimate
operation lives within such an envelope at every state.

At the justification layer, we capture this by introducing a predicate
`LegitimacyEnvelope F s`, abstractly representing that all required gates and
constraints hold for operation `F` at state `s`.
-/

namespace SigmaR

/--
Predicate: the operation satisfies its legitimacy envelope at state `s`.

This predicate stands for the conjunction of:
  • STC‑5 gates,
  • ALRP compliance,
  • bounded drift,
  • and related Tier‑2 constraints.

Its internal structure is intentionally abstract at this layer.
-/
constant LegitimacyEnvelope : Operation → State → Prop

/--
Tier‑2 legitimacy axiom:

If an operation is `Legitimate`, then it satisfies its legitimacy envelope
at every state.
-/
axiom envelope_required_for_legitimacy :
  ∀ {F : Operation},
    Legitimate F →
      ∀ s : State,
        LegitimacyEnvelope F s

/--
Derived theorem:

Legitimacy implies envelope satisfaction everywhere.
-/
theorem LegitimacyEnvelope_required_for_legitimacy
  {F : Operation}
  (hLeg : Legitimate F) :
  ∀ s : State,
    LegitimacyEnvelope F s :=
by
  exact envelope_required_for_legitimacy hLeg

end SigmaR
