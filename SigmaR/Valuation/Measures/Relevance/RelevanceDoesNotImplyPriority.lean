import SigmaR.StandingAlgebra_FormalCore

/-!
###############################################################################
# Relevance Does Not Imply Priority
###############################################################################

Relevance does not induce prioritization, ranking,
or preference ordering.

Non-relevant options fall out of scope structurally;
they are not deprioritized relative to relevant options.
###############################################################################
-/

namespace SigmaR

/--
Relevance does not imply priority.

Options outside relevance are excluded from scope,
not ranked as lower priority.
-/
axiom relevance_does_not_imply_priority :
  ∀ (R : Agent → State → Prop)
    (O₁ O₂ : State),
    ¬ (R (Classical.choice (Classical.decEq Agent)) O₁ →
       ¬ R (Classical.choice (Classical.decEq Agent)) O₂ →
       O₁ ≠ O₂)

end SigmaR
