import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Core.StructuralInterfaces

/-!
###############################################################################
# No Self Optimization
###############################################################################

The valuation system does not optimize its own measures.

No valuation dimension is assumed to be subject to
self-referential optimization.
###############################################################################
-/

namespace SigmaR

/--
No implication permitting a valuation measure to be
optimized with respect to itself is allowed.
-/
axiom no_self_optimization :
  ¬ (
    ∃ (M : Measure) (O : Obj),
      IsMeasure M ∧
      Optimizes O ∧
      TargetsMeasure O M ∧
      GeneratedFromMeasure O M
  )

end SigmaR


end SigmaR
