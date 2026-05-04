import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.DerivedValuations.TransformabilityValuation.TransformabilityValuation

/-!
###############################################################################
# Transformability Hysteresis
###############################################################################

This file introduces hysteresis in transformability valuation.

Hysteresis captures path dependence: current effective
transformability depends on prior states, not just
present conditions.

It does NOT:
• imply irrationality
• imply blame
• assert error
###############################################################################
-/

namespace SigmaR

/--
TransformabilityHysteresis T means that transformability valuation T
exhibits path-dependent behavior.
-/
constant TransformabilityHysteresis :
  TransformabilityValuation → Prop

end SigmaR
