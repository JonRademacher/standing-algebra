import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Core.StructuralInterfaces
import SigmaR.Valuation.Measures.StandingMeasure_Definition
import SigmaR.Valuation.Measures.CapacityMeasure_Definition

/-!
###############################################################################
# Independence: Standing Not Capacity
###############################################################################

Standing does not license or imply capacity.

Standing measures recognized status or admissible participation.
Capacity measures agent ability or potential.

No default implication from standing to capacity
is licensed.
###############################################################################
-/

namespace SigmaR

/--
No implication treating standing as constituting,
generating, or licensing capacity is permitted.
-/
axiom standing_not_capacity :
  ¬ (
    ∀ (a : Agent) (s : State),
      TreatedAsCapacityFromStandingMeasure a s
  )

end SigmaR
