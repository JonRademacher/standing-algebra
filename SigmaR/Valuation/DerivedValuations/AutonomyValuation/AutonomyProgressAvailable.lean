import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.DerivedValuations.AutonomyValuation.AutonomyProgressOptionSet

/-!
###############################################################################
# Autonomy Progress Available
###############################################################################

This file introduces the condition that autonomy-progress
options are available in the current structural context.

Availability states existence, not obligation.
###############################################################################
-/

namespace SigmaR

/--
AutonomyProgressAvailable S means that a set of
autonomy-progress options S exists.
-/
constant AutonomyProgressAvailable :
  AutonomyProgressOptionSet → Prop

end SigmaR
