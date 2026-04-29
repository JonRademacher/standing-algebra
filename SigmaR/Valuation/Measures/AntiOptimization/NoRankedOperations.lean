import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Core.StructuralInterfaces

/-!
###############################################################################
# No Ranked Operations
###############################################################################

Valuation measures do not induce rankings or orderings
over agents or states by default.
###############################################################################
-/

namespace SigmaR

/--
No implication from valuation measures to induced
rankings or orderings is permitted.
-/
axiom no_ranked_operations :
  ¬ (
    ∃ (M : Measure),
      IsMeasure M ∧
      InducesRanking M
  )

end SigmaR

