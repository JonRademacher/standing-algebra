import SigmaR.StandingAlgebra_FormalCore

/-!
###############################################################################
# Measurement Noise Permitted
###############################################################################

Measurements may vary due to noise, occlusion,
or frame dependence without indicating error.

Noise is an admissible feature of measurement,
not a defect.
###############################################################################
-/

namespace SigmaR

/--
No implication from measurement noise to error is permitted.
-/
axiom measurement_noise_permitted :
  ¬ (
    ∀ (a : Agent) (s : State),
      Noisy a s →
      Error a s
  )

end SigmaR
