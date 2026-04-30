module SigmaR.Justifications.Core_Legitimacy.iPFA_Justification

import SigmaR.Justifications.Core_Legitimacy.Agency_Justification
import SigmaR.Justifications.Core_Legitimacy.Autonomy_Justification

/-!
###############################################################################
# Justification of Internalized Perceptual Frame Agreements (IPFAs)
###############################################################################

Internalized Perceptual Frame Agreements (IPFAs) arise when perceptual frame
agreements (PFAs) are validated across time for an agent that already possesses
agency.

From *On Relevance*:

  • PFAs provide what categories are legible, what behaviors count as belonging,
    and what deviations trigger correction.

  • Identity claims granted internalized standing bind future selves.

  • Commitments across time become self‑constraints.

Temporal validation of perceptual frame agreements therefore produces
internalized frame agreements that bind future iterations of the agent.

Formally:

  Agentic a ∧ TemporallyValidatedPFA a → InternalizedFrameAgreement a

This grounds one of the necessary components for emergent autonomy.
-/

namespace SigmaR

/-- Predicate: the agent participates in a perceptual frame agreement (PFA). -/
constant PerceptualFrameAgreement : Agent → Prop

/-- Predicate: the agent has a perceptual frame agreement validated across time. -/
constant TemporallyValidatedPFA : Agent → Prop

/--
Tier‑2 justification axiom:

An Agentic individual with a temporally validated perceptual frame agreement
acquires an InternalizedFrameAgreement.
-/
axiom internalized_from_validated :
  ∀ {a : Agent},
    Agentic a →
    TemporallyValidatedPFA a →
    InternalizedFrameAgreement a

/--
Derived theorem:

Any agentic subject with a temporally validated PFA has an
InternalizedFrameAgreement.
-/
theorem InternalizedFrameAgreement_from_validation
  {a : Agent}
  (h₁ : Agentic a)
  (h₂ : TemporallyValidatedPFA a) :
  InternalizedFrameAgreement a :=
by
  exact internalized_from_validated h₁ h₂

end SigmaR
