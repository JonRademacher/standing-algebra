import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Core.StructuralInterfaces

/-!
###############################################################################
# No Fixed Point Assumption
###############################################################################

The valuation system does not assume the existence
of fixed points under state progression or valuation.
###############################################################################
-/

namespace SigmaR

/--
No implication from valuation structure to the existence
of fixed points is permitted.
-/
axiom no_fixed_point_assumption :
  ¬ (
    ∀ (M : Measure),
      IsMeasure M →
      HasFixedPoint M
  )

end SigmaR
