import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Core.StructuralInterfaces

/-!
###############################################################################
# No Metric Gaming
###############################################################################

The valuation system does not assume that metrics
can be gamed to achieve legitimate outcomes.
###############################################################################
-/

namespace SigmaR

/--
No implication permitting metric manipulation as a
route to legitimacy or success is allowed.
-/
axiom no_metric_gaming :
  ¬ (
    ∃ (M : Measure) (O : Obj),
      IsMeasure M ∧
      Optimizes O ∧
      GamesMetric O M
  )

end SigmaR
