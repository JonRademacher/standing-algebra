import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.DerivedValuations.ExitCostValuation

/-!
###############################################################################
# Exit Cost State
###############################################################################

This file introduces exit cost valuation as a state-relative
derived valuation.

It does NOT:
• redefine exit viability
• assert impossibility of exit
• imply intervention or authority

It is a valuation snapshot only.
###############################################################################
-/

namespace SigmaR

/--
An exit cost valuation relative to a specific agent and state.
-/
constant ExitCostState :
  Agent → State → ExitCostValuation

end SigmaR
