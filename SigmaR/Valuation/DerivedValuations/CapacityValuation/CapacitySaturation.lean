import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.DerivedValuations.CapacityValuation.CapacityValuation

/-!
###############################################################################
# Capacity Saturation
###############################################################################

This file introduces saturation in capacity valuation.

Saturation represents a boundary where additional demands
can no longer be absorbed without degradation.

It does NOT:
• imply incapacity in principle
• assert ceiling on future growth
• imply failure
###############################################################################
-/

namespace SigmaR

/--
CapacitySaturation C means that capacity valuation C
has reached a saturation boundary.
-/
constant CapacitySaturation :
  CapacityValuation → Prop

end SigmaR
