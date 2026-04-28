import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Measures.Relevance.IPFA_Definition

/-!
###############################################################################
# Relevance Failure Does Not Imply Incompetence
###############################################################################

Failure of relevance or agreement does not imply
cognitive deficiency or incompetence.

Divergence may arise from structural plurality alone.
###############################################################################
-/

namespace SigmaR

/--
Absence of relevance does not imply incompetence.
-/
axiom relevance_failure_not_incompetence :
  ∀ (a : Agent) (s : State),
    ¬ IPFA a s →
    True

end SigmaR
