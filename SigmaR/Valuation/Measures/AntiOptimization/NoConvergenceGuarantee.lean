import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Core.StructuralInterfaces

/-!
###############################################################################
# No Convergence Guarantee
###############################################################################

The valuation system does not assume convergence,
stability, or improvement over progression.
###############################################################################
-/

namespace SigmaR

/--
No implication from valuation structure to guaranteed
convergence is permitted.
-/
axiom no_convergence_guarantee :
  ¬ (
    ∀ (M : Measure),
      IsMeasure M →
      Converges M
  )

end SigmaR
