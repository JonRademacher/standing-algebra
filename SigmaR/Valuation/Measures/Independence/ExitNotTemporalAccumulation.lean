import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Measures.TemporalAccumulation_Definition
import SigmaR.Valuation.Measures.ExitViability_Definition

/-!
###############################################################################
# Exit Viability ≠ Temporal Accumulation
###############################################################################
-/

namespace SigmaR

axiom ExitNotTemporalAccumulation :
  ∀ (a : Agent) (s : State),
    ExitViable a →
    TemporalAccumulation a s ≠ 0

end SigmaR
