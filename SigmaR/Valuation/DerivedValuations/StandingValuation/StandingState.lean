import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.DerivedValuations.StandingValuation.StandingValuation

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

namespace SigmaR.Valuation.DerivedValuations.StandingValuation

/--
A standing valuation relative to a specific agent and state.
-/
axiom StandingState :
  Agent → State → StandingValuation

end SigmaR.Valuation.DerivedValuations.StandingValuation
