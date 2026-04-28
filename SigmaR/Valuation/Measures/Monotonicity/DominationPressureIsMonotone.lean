import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Measures.DominationPressure_Definition
import SigmaR.Valuation.Measures.Monotonicity.MeasureStructuralMonotonicity

/-!
###############################################################################
# Domination Pressure Is Monotone
###############################################################################

Domination pressure accumulates under state progression and does not
decrease without explicit structural intervention.
###############################################################################
-/

namespace SigmaR

axiom domination_pressure_monotone :
  ∀ (s₁ s₂ : State),
    StateLe s₁ s₂ →
    DominationPressure s₁ ≤ DominationPressure s₂

end SigmaR
