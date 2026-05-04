import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.DerivedValuations.RiskValuation.RiskValuation

/-!
###############################################################################
# Risk Respects Independence
###############################################################################

This file introduces the constraint that risk valuations
respect Independence inference firewalls.

Risk valuation must not reintroduce blocked
cross-measure or cross-valuation implications.

This file introduces no axioms.
###############################################################################
-/

namespace SigmaR

/--
RiskRespectsIndependence R means that risk valuation R
does not violate Independence constraints.
-/
constant RiskRespectsIndependence :
  RiskValuation → Prop

end SigmaR
