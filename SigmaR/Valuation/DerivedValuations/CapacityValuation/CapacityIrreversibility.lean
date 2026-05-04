import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.DerivedValuations.CapacityValuation.CapacityValuation

/-!
###############################################################################
# Capacity Irreversibility
###############################################################################

This file introduces irreversibility in capacity valuation.

Irreversibility captures cases where capacity degradation
cannot be undone within the current structural regime.

It does NOT:
• assert permanence in principle
• authorize intervention
• imply moral judgment
###############################################################################
-/

namespace SigmaR

/--
CapacityIrreversibility C means that capacity valuation C
is structurally irreversible once degraded.
-/
constant CapacityIrreversibility :
  CapacityValuation → Prop

end SigmaR
