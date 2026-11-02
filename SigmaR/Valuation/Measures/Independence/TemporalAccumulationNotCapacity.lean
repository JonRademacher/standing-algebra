import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Core.StructuralInterfaces
import SigmaR.Valuation.Measures.Definitions.TemporalAccumulation_Definition
import SigmaR.Valuation.Measures.Definitions.CapacityMeasure_Definition

open SigmaR.Valuation.Core

/-!
###############################################################################
# Independence: Temporal Accumulation Not Capacity
###############################################################################

Temporal accumulation does not license or imply loss of capacity.

Temporal accumulation captures irreversible or narrowing constraint
over time.
Capacity captures present ability or potential.

No default implication from temporal accumulation to capacity
loss is licensed.
###############################################################################
-/

namespace SigmaR.Valuation.Measures.Independence

/--
No implication treating temporal accumulation as eliminating,
revoking, or licensing the absence of capacity is permitted.
-/
axiom temporal_accumulation_not_capacity :
  ¬ (
    ∀ (a : Agent) (s : State),
      TreatedAsCapacityLostFromTemporalAccumulation a s
  )

end SigmaR.Valuation.Measures.Independence
