import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Measures.TemporalAccumulation_Definition
import SigmaR.Valuation.Measures.StandingMeasure_Definition

/-!
###############################################################################
# Standing ≠ Temporal Accumulation
###############################################################################
-/

namespace SigmaR

axiom StandingNotTemporalAccumulation :
  ∀ (a : Agent) (s : State),
    StandingMeasure a s ≠ TemporalAccumulation a s

end SigmaR
