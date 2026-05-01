import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.DerivedValuations.CouplingValuation

/-!
###############################################################################
# Coupling Hysteresis
###############################################################################

This file introduces hysteresis in coupling valuation.

Hysteresis captures path dependence:
the current coupling valuation depends on prior states,
not just current structure.

It does NOT imply:
• blame
• responsibility
• moral judgment
###############################################################################
-/

namespace SigmaR

/--
CouplingHysteresis C means that coupling valuation C
exhibits path-dependent behavior.
-/
constant CouplingHysteresis :
  CouplingValuation → Prop

end SigmaR
