import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Measures.TemporalAccumulation_Definition
import SigmaR.Valuation.Measures.Monotonicity.MeasureStructuralMonotonicity

/-!
###############################################################################
# Temporal Accumulation Is Irreversible
###############################################################################

Temporal accumulation cannot decrease under state progression alone.
###############################################################################
-/

namespace SigmaR

axiom temporal_accumulation_irreversible :
  ∀ (a : Agent) (s₁ s₂ : State),
    StateLe s₁ s₂ →
    TemporalAccumulation a s₁ ≤ TemporalAccumulation a s₂

end SigmaR
