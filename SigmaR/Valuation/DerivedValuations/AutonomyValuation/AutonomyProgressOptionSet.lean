import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.DerivedValuations.AutonomyValuation.AutonomyProgressOption

/-!
###############################################################################
# Autonomy Progress Option Set
###############################################################################

This file introduces sets of autonomy-progress options.

These sets define the structural boundary of available
autonomy-increasing paths.

This is not selection.
###############################################################################
-/

namespace SigmaR

/--
AutonomyProgressOptionSet S means that S is a set
of autonomy-progress options.
-/
constant AutonomyProgressOptionSet :
  AutonomyProgressOption → Prop

end SigmaR
