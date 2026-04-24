import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Measures.TemporalAccumulation_Definition
import SigmaR.Valuation.Measures.RiskLoad_Definition

/-!
###############################################################################
# Risk ≠ Temporal Accumulation
###############################################################################

Risk exposure is not equivalent to temporal
accumulation or irreversibility.

Risk may be transient or mitigated without
altering long-term structural binding.
###############################################################################
-/

namespace SigmaR

axiom RiskNotTemporalAccumulation :
  ∀ (a : Agent) (s : State),
    RiskLoad a s ≠ TemporalAccumulation a s

end SigmaR
