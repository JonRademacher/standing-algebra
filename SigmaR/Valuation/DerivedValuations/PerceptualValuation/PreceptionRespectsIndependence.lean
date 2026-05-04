import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.DerivedValuations.PerceptionValuation

/-!
###############################################################################
# Perception Respects Independence
###############################################################################

This file introduces the constraint that perception valuations
respect Independence inference firewalls.

Perception valuation must not reintroduce blocked
cross-measure implications.

This file introduces no axioms.
###############################################################################
-/

namespace SigmaR

/--
PerceptionRespectsIndependence P means that perception valuation P
does not violate Independence constraints.
-/
constant PerceptionRespectsIndependence :
  PerceptionValuation → Prop

end SigmaR
