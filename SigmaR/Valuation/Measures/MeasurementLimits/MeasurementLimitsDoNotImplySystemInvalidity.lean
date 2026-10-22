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

namespace SigmaR.Valuation.Measures.MeasurementLimits

/--
No implication from measurement limitations to system
invalidity is permitted.
-/
axiom measurement_limits_not_invalidity :
  ¬ (
    ∀ (a : Agent) (s : State),
      SigmaR.Valuation.Core.MeasurementLimited a s →
      SigmaR.Valuation.Core.SystemInvalid
  )

end SigmaR.Valuation.Measures.MeasurementLimits
