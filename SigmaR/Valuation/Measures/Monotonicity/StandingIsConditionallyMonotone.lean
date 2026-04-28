import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Measures.StandingMeasure_Definition
import SigmaR.Valuation.Measures.DominationPressure_Definition
import SigmaR.Valuation.Measures.Monotonicity.MeasureStructuralMonotonicity

/-!
###############################################################################
# Standing Is Conditionally Monotone
###############################################################################

Standing is not reduced without corresponding structural degradation.
###############################################################################
-/

namespace SigmaR

axiom standing_conditionally_monotone :
  ∀ (a : Agent) (s₁ s₂ : State),
    StateLe s₁ s₂ →
    DominationPressure s₁ ≤ DominationPressure s₂ →
    StandingMeasure a s₂ ≤ StandingMeasure a s₁

end SigmaR
