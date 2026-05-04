import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.DerivedValuations.AutonomyValuation.AutonomyValuation

/-!
###############################################################################
# Autonomy Hysteresis
###############################################################################

This file introduces hysteresis in autonomy valuation.

Hysteresis captures path dependence:
the current valuation depends on prior states,
not just current structure.

It does NOT imply:
• blame
• responsibility
• moral judgment
###############################################################################
-/

namespace SigmaR

/--
AutonomyHysteresis A means that autonomy valuation A
exhibits path-dependent behavior.
-/
constant AutonomyHysteresis :
  AutonomyValuation → Prop

end SigmaR
