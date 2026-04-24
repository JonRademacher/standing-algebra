import SigmaR.StandingAlgebra_FormalCore

/-!
###############################################################################
# Standing Measure — Definition
###############################################################################

Defines the valuation measure associated with standing.
This file introduces NO ordering over operations and NO legitimacy claims.
###############################################################################
-/

namespace SigmaR

/--
Standing measure for an agent in a given state.

This is a valuation-level quantity derived from standing,
not an objective, utility, or preference.
-/
constant StandingMeasure : Agent → State → Nat

end SigmaR
