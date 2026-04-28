import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Measures.StandingMeasure_Definition
import SigmaR.Valuation.Measures.Monotonicity.MeasureStructuralMonotonicity

/-!
###############################################################################
# Standing Not Created Ex Nihilo
###############################################################################

Standing cannot arise without prior structural conditions.
###############################################################################
-/

namespace SigmaR

axiom standing_not_created_ex_nihilo :
  ∀ (a : Agent) (s₁ s₂ : State),
    StateLe s₁ s₂ →
    StandingMeasure a s₁ ≤ StandingMeasure a s₂

end SigmaR
