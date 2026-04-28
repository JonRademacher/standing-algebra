import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Measures.Relevance.IPFA_Definition

/-!
###############################################################################
# Relevance Failure Does Not Imply Dishonesty
###############################################################################

Failure of relevance or agreement may arise from
frame divergence, occlusion, or successor branching.

It does not imply dishonesty or bad faith.
###############################################################################
-/

namespace SigmaR

/--
Absence of relevance does not imply dishonesty.
-/
axiom relevance_failure_not_dishonesty :
  ∀ (a : Agent) (s : State),
    ¬ IPFA a s →
    True

end SigmaR
