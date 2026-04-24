import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Measures.TemporalAccumulation_Definition
import SigmaR.Valuation.Measures.StandingMeasure_Definition

/-!
###############################################################################
# Temporal Accumulation ≠ Standing
###############################################################################

Temporal accumulation (time-binding, irreversibility)
is not reducible to standing.

Standing may be preserved while long-term,
irreversible structural harm accumulates.
###############################################################################
-/

namespace SigmaR

axiom TemporalAccumulationNotStanding :
  ∀ (a : Agent) (s : State),
    TemporalAccumulation a s ≠ StandingMeasure a s

end SigmaR
