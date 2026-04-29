import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Core.StructuralInterfaces

/-!
###############################################################################
# No Adaptive Objective Shift
###############################################################################

The valuation system does not adapt or generate objectives
based on internal valuation signals.

Goals are not endogenously redefined by measured outcomes.
###############################################################################
-/

namespace SigmaR

/--
No implication from valuation measures to the endogenous
generation or adaptation of objectives is permitted.
-/
axiom no_adaptive_objective_shift :
  ¬ (
    ∃ (M : Measure) (O : Obj),
      IsMeasure M ∧
      Optimizes O ∧
      GeneratedFromMeasure O M
  )

end SigmaR
