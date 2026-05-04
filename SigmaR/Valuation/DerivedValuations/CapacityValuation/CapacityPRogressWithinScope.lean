import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.DerivedValuations.CapacityValuation.CapacityProgressOptionSet

/-!
###############################################################################
# Capacity Progress Within Scope
###############################################################################

This file introduces the condition that capacity-progress
options lie within the structural scope of control.

This captures feasibility and control, not preference.
###############################################################################
-/

namespace SigmaR

/--
CapacityProgressWithinScope S means that the capacity-progress
options in S are within the effective scope of control.
-/
constant CapacityProgressWithinScope :
  CapacityProgressOptionSet → Prop

end SigmaR
