import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.ResponseSemantics.Response

/-!
###############################################################################
# Response Respects Independence
###############################################################################

This file introduces the constraint that a response
respects Independence inference firewalls.

Responses must not reintroduce blocked implications
between valuation measures.

This file introduces no axioms.
###############################################################################
-/

namespace SigmaR

/--
ResponseRespectsIndependence R means that response R
does not violate Independence constraints.
-/
constant ResponseRespectsIndependence :
  Response → Prop

end SigmaR
