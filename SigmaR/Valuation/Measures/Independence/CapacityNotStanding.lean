import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Core.StructuralInterfaces
import SigmaR.Valuation.Measures.StandingMeasure_Definition
import SigmaR.Valuation.Measures.CapacityMeasure_Definition

/-!
###############################################################################
# Independence: Capacity Not Standing
###############################################################################

Standing reflects recognized position or status.
Capacity expresses agent-internal ability or potential.

No default implication from standing measures to capacity
is licensed. Any relationship must be introduced explicitly
in higher layers or models.
###############################################################################
-/

namespace SigmaR

/--
No implication treating standing measures as implying
or licensing capacity is permitted.
-/
axiom standing_not_capacity :
  ¬ (
    ∀ (a : Agent) (s : State),
      TreatedAsCapacityFromStandingMeasure a s
  )

end SigmaR
