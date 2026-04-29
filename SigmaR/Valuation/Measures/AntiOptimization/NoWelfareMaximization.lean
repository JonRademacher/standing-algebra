import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Core.StructuralInterfaces

/-!
###############################################################################
# No Welfare Maximization
###############################################################################

SigmaR does not assume that any valuation measure
represents welfare to be maximized.
###############################################################################
-/

namespace SigmaR

/--
No implication treating valuation measures as welfare
quantities to be maximized is permitted.
-/
axiom no_welfare_maximization :
  ¬ (
    ∃ (M : Measure) (O : Obj),
      IsMeasure M ∧
      TreatedAsWelfare M ∧
      Optimizes O
  )

end SigmaR
