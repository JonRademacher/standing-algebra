import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Measures.ExitViability_Definition
import SigmaR.Valuation.Measures.TemporalAccumulation_Definition
import SigmaR.Valuation.Measures.Monotonicity.MeasureStructuralMonotonicity

/-!
###############################################################################
# Exit Viability Is Conditionally Antitone
###############################################################################

Exit viability decreases as irreversible constraint accumulates.
###############################################################################
-/

namespace SigmaR

axiom exit_viability_conditionally_antitone :
  ∀ (a : Agent) (s₁ s₂ : State),
    StateLe s₁ s₂ →
    TemporalAccumulation a s₁ ≤ TemporalAccumulation a s₂ →
    ExitViable a s₂ ≤ ExitViable a s₁

end SigmaR
