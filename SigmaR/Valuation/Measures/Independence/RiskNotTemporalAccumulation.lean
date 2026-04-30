import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Core.StructuralInterfaces
import SigmaR.Valuation.Measures.RiskLoad_Definition
import SigmaR.Valuation.Measures.TemporalAccumulation_Definition

/-!
###############################################################################
# Independence: Risk Not Temporal Accumulation
###############################################################################

Risk exposure does not license or imply temporal accumulation.

Risk load captures exposure to harm or uncertainty.
Temporal accumulation tracks irreversible or narrowing constraint
over time.

No default implication from risk exposure to temporal accumulation
is licensed.
###############################################################################
-/

namespace SigmaR

/--
No implication treating risk exposure as implying
or licensing temporal accumulation is permitted.
-/
axiom risk_not_temporal_accumulation :
  ¬ (
    ∀ (a : Agent) (s : State),
      TreatedAsTemporalAccumulationFromRiskLoad a s
  )

end SigmaR
