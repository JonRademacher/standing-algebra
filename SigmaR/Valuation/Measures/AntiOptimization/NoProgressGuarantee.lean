import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Core.StructuralInterfaces

/-!
###############################################################################
# No Progress Guarantee
###############################################################################

The valuation system does not assume progress,
advancement, or improvement over state progression.
###############################################################################
-/

namespace SigmaR

/--
No implication from valuation structure to guaranteed
progress across states is permitted.
-/
axiom no_progress_guarantee :
  ¬ (
    ∀ (M : Measure),
      IsMeasure M →
      GuaranteesProgress M
  )

end SigmaR
