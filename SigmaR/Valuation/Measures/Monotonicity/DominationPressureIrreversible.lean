import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Measures.DominationPressure_Definition
import SigmaR.Valuation.Measures.Monotonicity.MeasureStructuralMonotonicity

/-!
###############################################################################
# Domination Pressure Is Irreversible
###############################################################################

Domination pressure does not spontaneously decrease under
state progression.
###############################################################################
-/

namespace SigmaR

axiom domination_pressure_irreversible :
  ∀ (s₁ s₂ : State),
    StateLe s₁ s₂ →
    DominationPressure s₁ ≤ DominationPressure s₂

end SigmaR
