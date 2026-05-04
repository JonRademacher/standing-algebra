import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.DerivedValuations.CapacityValuation.CapacityValuation

/-!
###############################################################################
# Capacity Consumption
###############################################################################

This file introduces capacity consumption as a structural
effect on capacity valuation.

Consumption represents use or depletion relative
to available capacity.

It does NOT:
• imply misuse
• imply imprudence
• imply moral judgment
###############################################################################
-/

namespace SigmaR

/--
CapacityConsumption C₁ C₂ means that capacity valuation C₂
represents consumption relative to capacity valuation C₁.
-/
constant CapacityConsumption :
  CapacityValuation → CapacityValuation → Prop

end SigmaR
