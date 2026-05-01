import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.DerivedValuations.DerivedValuation

/-!
###############################################################################
# Valuation Respects Independence
###############################################################################

This file introduces the constraint that derived valuations
respect Independence inference firewalls.

Derived valuations must not reintroduce blocked
cross-measure implications.
###############################################################################
-/

namespace SigmaR

/--
ValuationRespectsIndependence V means that derived valuation V
does not violate Independence constraints.
-/
constant ValuationRespectsIndependence :
  DerivedValuation → Prop

end SigmaR
