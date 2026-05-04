import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.DerivedValuations.CapacityValuation.CapacityValuation

/-!
###############################################################################
# Capacity Fragility
###############################################################################

This file introduces fragility in capacity valuation.

Fragility represents sensitivity to structural or
contextual change, not weakness or failure.

It does NOT:
• imply incapacity in general
• assert unreliability
• imply fault
###############################################################################
-/

namespace SigmaR

/--
CapacityFragility C means that capacity valuation C
is structurally fragile.
-/
constant CapacityFragility :
  CapacityValuation → Prop

end SigmaR
