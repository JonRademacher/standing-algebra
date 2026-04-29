import SigmaR.StandingAlgebra_FormalCore

/-!
###############################################################################
# Measurement Noise Permitted
###############################################################################

Measurements may vary due to noise, occlusion,
or frame dependence without indicating error.
###############################################################################
-/

namespace SigmaR

/--
Measurement variability is permitted.
-/
axiom measurement_noise_permitted :
  ∀ (a : Agent) (s : State),
    True

end SigmaR
