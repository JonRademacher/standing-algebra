import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.DerivedValuations.CouplingValuation

/-!
###############################################################################
# Coupling Respects Independence
###############################################################################

This file introduces the constraint that coupling valuations
respect Independence inference firewalls.

Coupling valuation must not reintroduce blocked
cross-measure implications.
###############################################################################
-/

namespace SigmaR

/--
CouplingRespectsIndependence C means that coupling valuation C
does not violate Independence constraints.
-/
constant CouplingRespectsIndependence :
  CouplingValuation → Prop

end SigmaR
