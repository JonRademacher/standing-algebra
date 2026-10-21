import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Core.StructuralInterfaces

/-!
###############################################################################
# Measurement Limits Do Not Imply System Invalidity
###############################################################################

Measurement limitations do not imply that the
underlying system, model, or framework is invalid.

Limits on observation are expected structural features,
not defects.
###############################################################################
-/

namespace SigmaR

/--
No implication from measurement limitations to system
invalidity is permitted.
-/
axiom measurement_limits_not_invalidity :
  ¬ (
    ∀ (a : Agent) (s : State),
      MeasurementLimited a s →
      SystemInvalid
  )

end SigmaR
