import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Core.StructuralInterfaces
import SigmaR.Valuation.Measures.Definitions.StandingMeasure_Definition
import SigmaR.Valuation.Measures.Definitions.CapacityMeasure_Definition

open SigmaR.Valuation.Core

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

namespace SigmaR.Valuation.Measures.Independence

/--
No implication treating standing measures as implying
or licensing capacity is permitted.
-/
axiom standing_not_capacity :
  ¬ (
    ∀ (a : Agent) (s : State),
      TreatedAsCapacityFromStandingMeasure a s
  )

end SigmaR.Valuation.Measures.Independence
