import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.DerivedValuations.ExitCostValuation.ExitCostValuation

/-!
###############################################################################
# Exit Cost Respects Independence
###############################################################################

This file introduces the constraint that exit cost valuations
respect Independence inference firewalls.

Exit cost valuation must not reintroduce blocked
cross-measure implications.
###############################################################################
-/

namespace SigmaR.Valuation.DerivedValuations.ExitCostValuation

/--
ExitCostRespectsIndependence E means that exit cost valuation E
does not violate Independence constraints.
-/
axiom ExitCostRespectsIndependence :
  ExitCostValuation → Prop

end SigmaR.Valuation.DerivedValuations.ExitCostValuation
