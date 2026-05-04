import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.DerivedValuations.CapacityValuation.CapacityValuation

/-!
###############################################################################
# Capacity Respects Independence
###############################################################################

This file introduces the constraint that capacity valuations
respect Independence inference firewalls.

Capacity valuation must not reintroduce blocked
cross-measure implications.

This file introduces no axioms.
###############################################################################
-/

namespace SigmaR

/--
CapacityRespectsIndependence C means that capacity valuation C
does not violate Independence constraints.
-/
constant CapacityRespectsIndependence :
  CapacityValuation → Prop

end SigmaR
