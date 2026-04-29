import SigmaR.StandingAlgebra_FormalCore

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
    ∀ (s : State),
      MeasurementLimited s →
      SystemInvalid
  )

end SigmaR
``
