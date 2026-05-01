import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.DerivedValuations.StandingValuation

/-!
###############################################################################
# Standing Level
###############################################################################

This file introduces the notion of a standing level.

Standing levels are quantitative or ordered indicators
of standing valuation, without normative interpretation.

They do NOT:
• assert thresholds
• assert desirability
• imply legitimacy
###############################################################################
-/

namespace SigmaR

/--
A standing level associated with a standing valuation.
-/
constant StandingLevel : StandingValuation → Val

end SigmaR
