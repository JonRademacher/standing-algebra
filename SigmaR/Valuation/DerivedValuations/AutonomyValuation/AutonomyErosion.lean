import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.DerivedValuations.AutonomyValuation.AutonomyValuation

/-!
###############################################################################
# Autonomy Erosion
###############################################################################

This file introduces erosion in autonomy valuation.

Erosion captures gradual or cumulative diminishment
of autonomy without discrete loss events.

It does NOT:
• imply negligence
• imply intent
• justify intervention
###############################################################################
-/

namespace SigmaR

/--
AutonomyErosion A means that autonomy valuation A
is undergoing structural erosion.
-/
constant AutonomyErosion :
  AutonomyValuation → Prop

end SigmaR
