import SigmaR.StandingAlgebra_FormalCore

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
Measurement disagreement does not imply error.
-/
axiom measurement_disagreement_not_error :
  ∀ (a₁ a₂ : Agent) (s : State),
    True

end SigmaR
