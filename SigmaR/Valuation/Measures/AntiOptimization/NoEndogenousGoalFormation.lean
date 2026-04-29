import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Core.StructuralInterfaces

/-!
###############################################################################
# No Endogenous Goal Formation
###############################################################################

The valuation system does not generate its own goals
from internal measures or dynamics.
###############################################################################
-/

namespace SigmaR

/--
No implication from valuation measures to the endogenous
generation of objectives is permitted.
-/
axiom no_endogenous_goal_formation :
  ¬ (
    ∃ (M : Measure) (O : Obj),
      IsMeasure M ∧
      GeneratedFromMeasure O M
  )

end SigmaR
