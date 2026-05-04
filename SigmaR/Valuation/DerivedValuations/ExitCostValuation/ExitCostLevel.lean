import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.DerivedValuations.ExitCostValuation

/-!
###############################################################################
# Exit Cost Level
###############################################################################

This file introduces the notion of an exit cost level.

Exit cost levels are quantitative or ordered indicators
of exit cost valuation, without normative interpretation.

They do NOT:
• imply desirability
• justify restriction
• authorize coercion
###############################################################################
-/

namespace SigmaR

/--
An exit cost level associated with an exit cost valuation.
-/
constant ExitCostLevel : ExitCostValuation → Val

end SigmaR
