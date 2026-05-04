import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.DerivedValuations.AutonomyValuation.AutonomyProgressOptionSet

/-!
###############################################################################
# Autonomy Omission Maintains Constraint
###############################################################################

This file introduces the notion that omission of
autonomy-progress usage maintains a structural constraint
when progress was available.

This names omission structurally, not morally.
###############################################################################
-/

namespace SigmaR

/--
AutonomyOmissionMaintainsConstraint S means that
failure to engage available autonomy-progress options
maintains the autonomy constraint structurally.
-/
constant AutonomyOmissionMaintainsConstraint :
  AutonomyProgressOptionSet → Prop

end SigmaR
