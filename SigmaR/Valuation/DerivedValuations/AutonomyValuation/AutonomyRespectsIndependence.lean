import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.DerivedValuations.AutonomyValuation.AutonomyValuation

/-!
###############################################################################
# Autonomy Respects Independence
###############################################################################

This file introduces the constraint that autonomy
valuations respect Independence inference firewalls.

Autonomy valuation must not reintroduce blocked
cross-valuation implications (e.g. consent, authority,
or legitimacy).

This file introduces no axioms.
###############################################################################
-/

namespace SigmaR

/--
AutonomyRespectsIndependence A means that autonomy valuation A
does not violate Independence constraints.
-/
constant AutonomyRespectsIndependence :
  AutonomyValuation → Prop

end SigmaR
