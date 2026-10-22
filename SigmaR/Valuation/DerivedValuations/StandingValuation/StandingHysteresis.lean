import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.DerivedValuations.StandingValuation.StandingValuation

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

namespace SigmaR.Valuation.DerivedValuations.StandingValuation

/--
StandingHysteresis S means that standing valuation S
exhibits path-dependent behavior.
-/
axiom StandingHysteresis :
  StandingValuation → Prop

end SigmaR.Valuation.DerivedValuations.StandingValuation
