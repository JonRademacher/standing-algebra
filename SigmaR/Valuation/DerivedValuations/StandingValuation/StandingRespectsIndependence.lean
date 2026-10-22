import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.DerivedValuations.StandingValuation.StandingValuation

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

namespace SigmaR.Valuation.DerivedValuations.StandingValuation

/--
StandingRespectsIndependence S means that standing valuation S
does not violate Independence constraints.
-/
axiom StandingRespectsIndependence :
  StandingValuation → Prop

end SigmaR.Valuation.DerivedValuations.StandingValuation
