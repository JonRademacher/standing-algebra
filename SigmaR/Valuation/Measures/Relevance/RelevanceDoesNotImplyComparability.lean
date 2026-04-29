import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Core.StructuralInterfaces

/-!
###############################################################################
# Relevance Does Not Imply Comparability
###############################################################################

Relevance does not permit comparison, ranking,
or ordering of valuation measures.
###############################################################################
-/

namespace SigmaR

/--
No implication permitting relevance to authorize
comparability, ranking, or ordering of measures
is allowed.
-/
axiom relevance_not_comparable :
  ¬ (
    ∀ (a : Agent) (s : State) (M₁ M₂ : Measure),
      IPFA a s →
      InducesRanking M₁ ∨ InducesRanking M₂
  )

end SigmaR

