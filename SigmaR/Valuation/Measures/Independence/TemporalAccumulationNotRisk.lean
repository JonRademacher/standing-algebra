import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Measures.TemporalAccumulation_Definition
import SigmaR.Valuation.Measures.RiskLoad_Definition

/-!
###############################################################################
# Temporal Accumulation ≠ Risk
###############################################################################

Temporal accumulation (time-binding, irreversibility)
is not reducible to risk exposure.

Long-term structural harm can accrue without
corresponding increases in risk metrics.
###############################################################################
-/

namespace SigmaR

axiom TemporalAccumulationNotRisk :
  ∀ (a : Agent) (s : State),
    TemporalAccumulation a s ≠ RiskLoad a s

end SigmaR
