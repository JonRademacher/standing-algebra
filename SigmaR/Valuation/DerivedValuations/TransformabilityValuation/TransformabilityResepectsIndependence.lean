import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.DerivedValuations.TransformabilityValuation.TransformabilityValuation

/-!
###############################################################################
# Transformability Respects Independence
###############################################################################

This file introduces the constraint that transformability
valuations respect Independence inference firewalls.

Transformability valuation must not reintroduce blocked
cross-measure implications.

This file introduces no axioms.
###############################################################################
-/

namespace SigmaR

/--
TransformabilityRespectsIndependence T means that
transformability valuation T does not violate
Independence constraints.
-/
constant TransformabilityRespectsIndependence :
  TransformabilityValuation → Prop

end SigmaR
