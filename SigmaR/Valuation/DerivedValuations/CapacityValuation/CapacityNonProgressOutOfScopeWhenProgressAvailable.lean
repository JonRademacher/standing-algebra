import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.DerivedValuations.CapacityValuation.CapacityProgressOptionSet

/-!
###############################################################################
# Capacity Non-Progress Out Of Scope When Progress Available
###############################################################################

This file encodes the ratchet boundary:

When capacity-progress options exist within scope,
non-capacity-increasing options become out of scope
for non-dominating evaluation.

This is NOT preference or optimization.
###############################################################################
-/

namespace SigmaR

/--
CapacityNonProgressOutOfScopeWhenProgressAvailable S
means that non-progress options are out of scope
when progress options S are available.
-/
constant CapacityNonProgressOutOfScopeWhenProgressAvailable :
  CapacityProgressOptionSet → Prop

end SigmaR
