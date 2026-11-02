import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Core.StructuralInterfaces

open SigmaR.Valuation.Core

/-!
###############################################################################
# No Measure Targeting
###############################################################################

Valuation measures are not targets to be optimized.
They are descriptive, not prescriptive.
###############################################################################
-/

namespace SigmaR.Valuation.Measures.AntiOptimization

/--
No implication treating valuation measures as targets
of optimization or action is permitted.
-/
axiom no_measure_targeting :
  ¬ (
    ∃ (M : Measure) (O : Obj),
      IsMeasure M ∧
      Optimizes O ∧
      TargetsMeasure O M
  )

end SigmaR.Valuation.Measures.AntiOptimization
