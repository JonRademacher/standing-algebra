import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.DerivedValuations.StandingValuation

/-!
###############################################################################
# Standing Respects Independence
###############################################################################

This file introduces the constraint that standing valuations
respect Independence inference firewalls.

Standing valuation must not reintroduce blocked
cross-measure implications.
###############################################################################
-/

namespace SigmaR

/--
StandingRespectsIndependence S means that standing valuation S
does not violate Independence constraints.
-/
constant StandingRespectsIndependence :
  StandingValuation → Prop

end SigmaR
