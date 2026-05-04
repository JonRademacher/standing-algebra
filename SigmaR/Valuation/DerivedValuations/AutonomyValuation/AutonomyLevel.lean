import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.DerivedValuations.AutonomyValuation.AutonomyValuation

/-!
###############################################################################
# Autonomy Level
###############################################################################

This file introduces the notion of an autonomy level.

Autonomy levels are numerical or ordered indicators
of autonomy valuation, without normative interpretation.

They do NOT:
• assert thresholds
• assert desirability
• assert legitimacy
###############################################################################
-/

namespace SigmaR

/--
An autonomy level associated with an autonomy valuation.
-/
constant AutonomyLevel : AutonomyValuation → Val

end SigmaR
