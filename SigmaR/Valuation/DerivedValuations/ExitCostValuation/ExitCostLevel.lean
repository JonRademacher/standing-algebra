import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.DerivedValuations.ExitCostValuation.ExitCostValuation

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

namespace SigmaR.Valuation.DerivedValuations.ExitCostValuation

/--
An exit cost level associated with an exit cost valuation.
-/
axiom ExitCostLevel : ExitCostValuation → Val

end SigmaR.Valuation.DerivedValuations.ExitCostValuation
