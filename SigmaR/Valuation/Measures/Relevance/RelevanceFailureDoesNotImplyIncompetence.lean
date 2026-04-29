import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Core.StructuralInterfaces
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
No implication treating absence of IPFA as incompetence
or cognitive deficiency is permitted.
-/
axiom relevance_failure_not_incompetence :
  ¬ (
    ∀ (a : Agent) (s : State),
      ¬ IPFA a s →
      TreatedAsIncompetent a s
  )

end SigmaR
