import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Measures.CapacityMeasure_Definition
import SigmaR.Valuation.Measures.Monotonicity.MeasureStructuralMonotonicity

/-!
###############################################################################
# Capacity Not Created Ex Nihilo
###############################################################################

Capacity does not arise spontaneously under state progression.
It must be supported by prior structure.
###############################################################################
-/

namespace SigmaR

axiom capacity_not_created_ex_nihilo :
  ∀ (a : Agent) (s₁ s₂ : State),
    StateLe s₁ s₂ →
    CapacityMeasure a s₁ ≤ CapacityMeasure a s₂

end SigmaR
