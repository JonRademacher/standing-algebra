import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.DerivedValuations.CapacityValuation.CapacityProgressOptionSet

/-!
###############################################################################
# Capacity Progress Available
###############################################################################

This file introduces the condition that capacity-progress
options are available in the current structural context.

Availability states existence, not obligation or choice.
###############################################################################
-/

namespace SigmaR

/--
CapacityProgressAvailable S means that a set of capacity-progress
options S exists in the current context.
-/
constant CapacityProgressAvailable :
  CapacityProgressOptionSet → Prop

end SigmaR
