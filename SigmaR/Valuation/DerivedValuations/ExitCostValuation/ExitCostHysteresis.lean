import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.DerivedValuations.ExitCostValuation

/-!
###############################################################################
# Exit Cost Hysteresis
###############################################################################

This file introduces hysteresis in exit cost valuation.

Hysteresis captures path dependence:
the current exit cost valuation depends on prior states,
not just current structure.

It does NOT imply:
• blame
• responsibility
• moral judgment
###############################################################################
-/

namespace SigmaR

/--
ExitCostHysteresis E means that exit cost valuation E
exhibits path-dependent behavior.
-/
constant ExitCostHysteresis :
  ExitCostValuation → Prop

end SigmaR
