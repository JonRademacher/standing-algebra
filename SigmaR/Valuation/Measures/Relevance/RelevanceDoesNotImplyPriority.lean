import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Core.StructuralInterfaces

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
No implication permitting relevance to induce
priority, ranking, or preference ordering is allowed.
-/
axiom relevance_does_not_imply_priority :
  ¬ (
    ∀ (a : Agent) (s : State) (M : Measure),
      IPFA a s →
      InducesRanking M
  )

end SigmaR

