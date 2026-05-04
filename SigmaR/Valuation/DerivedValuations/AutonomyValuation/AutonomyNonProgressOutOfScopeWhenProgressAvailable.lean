import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.DerivedValuations.AutonomyValuation.AutonomyProgressOptionSet

/-!
###############################################################################
# Autonomy Non-Progress Out Of Scope When Progress Available
###############################################################################

This file encodes the autonomy ratchet boundary:

When autonomy-progress options exist within scope,
non-autonomy-increasing paths become out of scope
for non-dominating evaluation.

This is NOT preference or optimization.
###############################################################################
-/

namespace SigmaR

/--
AutonomyNonProgressOutOfScopeWhenProgressAvailable S
means that non-progress options are out of scope
when progress options S are available.
-/
constant AutonomyNonProgressOutOfScopeWhenProgressAvailable :
  AutonomyProgressOptionSet → Prop

end SigmaR
