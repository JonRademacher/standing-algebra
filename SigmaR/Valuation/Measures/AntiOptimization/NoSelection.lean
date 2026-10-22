import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Core.StructuralInterfaces

open SigmaR.Valuation.Core

/-!
###############################################################################
# No Selection
###############################################################################

The valuation system does not assume selection,
fitness, or survival-based dynamics.
###############################################################################
-/

namespace SigmaR.Valuation.Measures.AntiOptimization

/--
No implication from valuation structure to assumed
selection or fitness-based dynamics is permitted.
-/
axiom no_selection :
  ¬ (
    ∀ (M : Measure),
      IsMeasure M →
      AssumesSelection M
  )

end SigmaR.Valuation.Measures.AntiOptimization

