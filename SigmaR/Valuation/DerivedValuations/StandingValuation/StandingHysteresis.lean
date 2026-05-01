import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.DerivedValuations.StandingValuation

/-!
###############################################################################
# Standing Hysteresis
###############################################################################

This file introduces hysteresis in standing valuation.

Hysteresis captures path dependence:
the current standing valuation depends on prior states,
not just current structure.

It does NOT imply:
• blame
• responsibility
• moral judgment
###############################################################################
-/

namespace SigmaR

/--
StandingHysteresis S means that standing valuation S
exhibits path-dependent behavior.
-/
constant StandingHysteresis :
  StandingValuation → Prop

end SigmaR
