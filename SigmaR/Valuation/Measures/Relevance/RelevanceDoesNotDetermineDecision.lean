import SigmaR.StandingAlgebra_FormalCore

/-!
###############################################################################
# Relevance Does Not Determine Decision
###############################################################################

Epistemic relevance does not determine decisions,
outcomes, or selections.

Relevance constrains consideration, not resolution.
###############################################################################
-/

namespace SigmaR

/--
Relevance does not determine decision outcomes.
-/
axiom relevance_does_not_determine_decision :
  ∀ (R : Agent → State → Prop)
    (D : State → State),
    ¬ (∀ (a : Agent) (s : State),
          R a s → D s = s)

end SigmaR
