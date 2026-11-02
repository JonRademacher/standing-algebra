import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Core.StructuralInterfaces
import SigmaR.Valuation.Measures.Definitions.StandingMeasure_Definition
import SigmaR.Valuation.Measures.Definitions.CapacityMeasure_Definition

open SigmaR.Valuation.Core

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

namespace SigmaR.Valuation.Measures.Independence

/--
No implication treating standing as constituting,
generating, or licensing capacity is permitted.
-/
axiom standing_not_capacity :
  ¬ (
    ∀ (a : Agent) (s : State),
      TreatedAsCapacityFromStandingMeasure a s
  )

end SigmaR.Valuation.Measures.Independence
