import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.DerivedValuations.StandingValuation

/-!
###############################################################################
# Standing State
###############################################################################

This file introduces standing valuation as a state-relative
derived valuation.

It does NOT:
• redefine σ from the Formal Core
• assert agency
• imply authority or intervention

It is a valuation snapshot only.
###############################################################################
-/

namespace SigmaR

/--
A standing valuation relative to a specific agent and state.
-/
constant StandingState :
  Agent → State → StandingValuation

end SigmaR
