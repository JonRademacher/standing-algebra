import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Measures.AutonomyMeasure_Definition
import SigmaR.Valuation.Measures.DominationPressure_Definition
import SigmaR.Valuation.Measures.Monotonicity.MeasureStructuralMonotonicity

/-!
###############################################################################
# Autonomy Is Conditionally Monotone
###############################################################################

Autonomy does not increase under increasing domination pressure.
###############################################################################
-/

namespace SigmaR

axiom autonomy_conditionally_monotone :
  ∀ (a : Agent) (s₁ s₂ : State),
    StateLe s₁ s₂ →
    DominationPressure s₁ ≤ DominationPressure s₂ →
    AutonomyMeasure a s₂ ≤ AutonomyMeasure a s₁

end SigmaR
