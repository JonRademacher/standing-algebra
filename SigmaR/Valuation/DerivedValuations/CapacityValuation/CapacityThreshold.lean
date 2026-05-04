import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.DerivedValuations.CapacityValuation.CapacityValuation

/-!
###############################################################################
# Capacity Threshold
###############################################################################

This file introduces thresholds in capacity valuation.

Thresholds represent structural demarcations where
capacity behavior changes qualitatively.

They do NOT:
• mandate action
• imply collapse by default
• assert normative evaluation
###############################################################################
-/

namespace SigmaR

/--
CapacityThreshold C means that capacity valuation C
is associated with a structural threshold.
-/
constant CapacityThreshold :
  CapacityValuation → Prop

end SigmaR
