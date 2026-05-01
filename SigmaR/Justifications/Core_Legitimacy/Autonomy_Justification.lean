import SigmaR.StandingAlgebra_RegimeStacked

/-!
###############################################################################
# Justification of Autonomy from Agency and Validated Internalized Frames
###############################################################################

Autonomy in this framework is not posited as a primitive but emerges from:

  (1) Agency (a locus of will), and
  (2) Internalized perceptual frame agreements (IPFAs)
  (3) Temporal validation of those internalized frames

From *On Relevance*:

  • Identity claims granted internalized standing bind future selves.
  • This is the genesis of internalized perceptual frame agreements (IPFAs).
  • Commitments in this temporal sense become self‑constraints.
  • Personal warrant enters through temporally validated perceptual frames.

Standing Algebra presupposes agents capable of coordination without
prescribing their ontology. At the justification layer we therefore
introduce predicates capturing:

  - Internalized perceptual frame agreement,
  - Temporal validation of those frames,
  - Autonomy as emergent personal warrant.

This yields:

  Agentic a ∧ IPFA a ∧ TemporalValidation a → Autonomous a
-/

namespace SigmaR

/-- Predicate: the agent has an internalized perceptual frame agreement (IPFA). -/
constant InternalizedFrameAgreement : Agent → Prop

/-- Predicate: the agent's internalized frames are validated across time. -/
constant TemporalValidation : Agent → Prop

/-- Predicate: the agent is autonomous (self‑authorized). -/
constant Autonomous : Agent → Prop

/--
Tier‑2 legitimacy axiom for autonomy:

An agent becomes Autonomous when:
  • the agent is agentic,
  • possesses an internalized perceptual frame agreement,
  • and that frame is temporally validated.
-/
axiom autonomy_from_frames :
  ∀ {a : Agent},
    Agentic a →
    InternalizedFrameAgreement a →
    TemporalValidation a →
    Autonomous a

/--
Derived theorem:

Any agentic subject with validated internalized frames is autonomous.
-/
theorem Autonomy_from_validated_frames
  {a : Agent}
  (h₁ : Agentic a)
  (h₂ : InternalizedFrameAgreement a)
  (h₃ : TemporalValidation a) :
  Autonomous a :=
by
  exact autonomy_from_frames h₁ h₂ h₃

end SigmaR
