import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.DerivedValuations.RiskValuation.RiskValuation

/-!
###############################################################################
# Risk State
###############################################################################

This file introduces risk valuation as a state-relative
derived valuation.

It represents a snapshot of structural risk for an agent
in a given state.

It does NOT:
• redefine hazard or probability
• imply responsibility
• authorize intervention
###############################################################################
-/

namespace SigmaR

/--
A risk valuation relative to a specific agent and state.
-/
constant RiskState :
  Agent → State → RiskValuation

end SigmaR
