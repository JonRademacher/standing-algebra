import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Measures.RiskInheritance_Definition
import SigmaR.Valuation.Measures.Monotonicity.MeasureStructuralMonotonicity

/-!
###############################################################################
# Risk Inheritance Is Monotone
###############################################################################

Inherited risk is monotone under state progression.
###############################################################################
-/

namespace SigmaR

axiom risk_inheritance_monotone :
  ∀ (a : Agent) (s₁ s₂ : State),
    StateLe s₁ s₂ →
    RiskInheritance a s₁ ≤ RiskInheritance a s₂

end SigmaR
