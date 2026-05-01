import SigmaR.StandingAlgebra_FormalCore

/-!
###############################################################################
# Autonomy Condition
###############################################################################

This file introduces a structural condition associated
with autonomy.

It does NOT define autonomy.
It does NOT assert necessary or sufficient conditions.
###############################################################################
-/

namespace SigmaR

/--
AutonomyCondition i indicates that agent i satisfies
a structural autonomy-related condition under some theory.
-/
constant AutonomyCondition : Agent → Prop

end SigmaR
