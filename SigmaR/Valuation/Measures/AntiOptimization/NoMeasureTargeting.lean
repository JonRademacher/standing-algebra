import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Core.StructuralInterfaces

/-!
###############################################################################
# No Measure Targeting
###############################################################################

Valuation measures are not targets to be optimized.
They are descriptive, not prescriptive.
###############################################################################
-/

namespace SigmaR

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

end SigmaR
