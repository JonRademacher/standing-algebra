import SigmaR.StandingAlgebra_FormalCore

/-!
###############################################################################
# Relevance Does Not Imply Obligation
###############################################################################

Epistemic relevance does not entail obligation, duty,
or required action.

Relevance establishes what may be considered,
not what must be done.
###############################################################################
-/

namespace SigmaR

/--
Relevance does not imply obligation.
-/
axiom relevance_does_not_imply_obligation :
  ∀ (R : Agent → State → Prop),
    ¬ (∀ (a : Agent) (s : State),
          R a s → True)

end SigmaR
