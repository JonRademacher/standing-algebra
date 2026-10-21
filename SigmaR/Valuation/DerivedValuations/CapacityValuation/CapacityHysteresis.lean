import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.DerivedValuations.CapacityValuation.CapacityValuation

/-!
###############################################################################
# Capacity Hysteresis
###############################################################################

This file introduces hysteresis in capacity valuation.

Hysteresis captures path dependence: current effective
capacity depends on prior states, not just present conditions.

It does NOT:
• imply irrationality
• imply blame
• assert error
###############################################################################
-/

namespace SigmaR

/--
CapacityHysteresis C means that capacity valuation C
is path dependent: its value at a state depends on
the history through which that state was reached.
-/
axiom CapacityHysteresis :
  CapacityValuation → Prop

end SigmaR
