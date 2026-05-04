import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.DerivedValuations.AutonomyValuation.AutonomyProgressOptionSet

/-!
###############################################################################
# Autonomy Progress Within Scope
###############################################################################

This file introduces the condition that autonomy-progress
options lie within the effective scope of control.

Scope captures feasibility and control, not preference.
###############################################################################
-/

namespace SigmaR

/--
AutonomyProgressWithinScope S means that the autonomy-progress
options in S are within scope.
-/
constant AutonomyProgressWithinScope :
  AutonomyProgressOptionSet → Prop

end SigmaR
