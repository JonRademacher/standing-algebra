import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Measures.CapacityMeasure_Definition
import SigmaR.Valuation.Measures.StructuralDebt_Definition
import SigmaR.Valuation.Measures.Monotonicity.MeasureStructuralMonotonicity

/-!
###############################################################################
# Capacity Is Conditionally Monotone
###############################################################################

Capacity does not increase in the presence of increasing structural debt.
###############################################################################
-/

namespace SigmaR

axiom capacity_conditionally_monotone :
  ∀ (a : Agent) (s₁ s₂ : State),
    StateLe s₁ s₂ →
    StructuralDebt a s₁ ≤ StructuralDebt a s₂ →
    CapacityMeasure a s₂ ≤ CapacityMeasure a s₁

end SigmaR
