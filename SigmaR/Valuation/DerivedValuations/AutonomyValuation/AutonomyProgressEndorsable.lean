import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.DerivedValuations.AutonomyValuation.AutonomyProgressOptionSet

/-!
###############################################################################
# Autonomy Progress Endorsable
###############################################################################

This file introduces endorsability of autonomy-progress
options under declared structural constraints.

Endorsability does NOT imply preference or selection.
###############################################################################
-/

namespace SigmaR

/--
AutonomyProgressEndorsable S means that the autonomy-progress
options in S are structurally endorsable.
-/
constant AutonomyProgressEndorsable :
  AutonomyProgressOptionSet → Prop

end SigmaR
