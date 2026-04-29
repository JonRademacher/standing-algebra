import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Core.StructuralInterfaces

/-!
###############################################################################
# Measurement Disagreement Does Not Imply Error
###############################################################################

Disagreement between measurements does not imply
error, dishonesty, or incompetence.

Divergence may arise from noise, occlusion,
frame dependence, or locality.
###############################################################################
-/

namespace SigmaR

/--
No implication from measurement disagreement to error
is permitted.
-/
axiom measurement_disagreement_not_error :
  ¬ (
    ∀ (a₁ a₂ : Agent) (s : State),
      Measured a₁ s ≠ Measured a₂ s →
      Error a₁ s ∨ Error a₂ s
  )

end SigmaR
