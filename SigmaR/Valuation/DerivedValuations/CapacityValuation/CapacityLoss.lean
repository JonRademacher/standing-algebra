import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.DerivedValuations.CapacityValuation.CapacityValuation

/-!
###############################################################################
# Capacity Loss
###############################################################################

This file introduces the structural notion of loss
in capacity valuation.

Capacity loss represents reduction in effective,
usable capacity under structural conditions.

It does NOT:
• imply fault
• imply incompetence
• imply blame or responsibility
###############################################################################
-/

namespace SigmaR

/--
CapacityLoss C₁ C₂ means that capacity valuation C₂
represents a loss relative to capacity valuation C₁.
-/
constant CapacityLoss :
  CapacityValuation → CapacityValuation → Prop

end SigmaR
