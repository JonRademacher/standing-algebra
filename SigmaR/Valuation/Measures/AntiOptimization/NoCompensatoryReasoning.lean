import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Core.StructuralInterfaces

/-!
###############################################################################
# No Compensatory Reasoning
###############################################################################

Valuation does not allow compensation of loss
in one dimension by gain in another.
###############################################################################
-/

namespace SigmaR.Valuation.Measures.AntiOptimization

open SigmaR.Valuation.Core

/--
No implication from one valuation measure to compensatory
justification via another measure is permitted.
-/
axiom no_compensatory_reasoning :
  ¬ (
    ∃ (M₁ M₂ : Measure),
      IsMeasure M₁ ∧
      IsMeasure M₂ ∧
      M₁ ≠ M₂ ∧
      Compensates M₂ M₁
  )

end SigmaR.Valuation.Measures.AntiOptimization
