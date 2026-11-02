import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Core.StructuralInterfaces

open SigmaR.Valuation.Core

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

namespace SigmaR.Valuation.Measures.MeasurementLimits

/--
No implication from measurement noise to error is permitted.
-/
axiom measurement_noise_permitted :
  ¬ (
    ∀ (a : Agent) (s : State),
      Noisy a s →
      Error a s
  )

end SigmaR.Valuation.Measures.MeasurementLimits
