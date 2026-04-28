import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Measures.TemporalAccumulation_Definition
import SigmaR.Valuation.Measures.Monotonicity.MeasureStructuralMonotonicity

/-!
###############################################################################
# Temporal Accumulation Is Monotone
###############################################################################

Temporal accumulation is monotone with respect to state progression.
###############################################################################
-/

namespace SigmaR

axiom temporal_accumulation_monotone :
  ∀ (a : Agent) (s₁ s₂ : State),
    StateLe s₁ s₂ →
    TemporalAccumulation a s₁ ≤ TemporalAccumulation a s₂

end SigmaR
