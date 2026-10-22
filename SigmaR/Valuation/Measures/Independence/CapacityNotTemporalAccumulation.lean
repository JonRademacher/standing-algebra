import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Core.StructuralInterfaces
import SigmaR.Valuation.Measures.Definitions.CapacityMeasure_Definition
import SigmaR.Valuation.Measures.Definitions.TemporalAccumulation_Definition

open SigmaR.Valuation.Core

/-!
###############################################################################
# Independence: Capacity Not Temporal Accumulation
###############################################################################

Capacity expresses present ability or potential.
Temporal accumulation tracks irreversible constraint over time.

No default implication from capacity measures to temporal
accumulation is licensed.
###############################################################################
-/

namespace SigmaR.Valuation.Measures.Independence

/--
No implication treating capacity measures as implying
or licensing assumptions of temporal accumulation is permitted.
-/
axiom capacity_not_temporal_accumulation :
  ¬ (
    ∀ (a : Agent) (s : State),
      TreatedAsTemporalAccumulationFromCapacityMeasure a s
  )

end SigmaR.Valuation.Measures.Independence
