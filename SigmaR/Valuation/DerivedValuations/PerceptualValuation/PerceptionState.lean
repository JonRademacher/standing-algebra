import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.DerivedValuations.PerceptionValuation

/-!
###############################################################################
# Perception State
###############################################################################

This file introduces perception valuation as a state-relative
derived valuation.

It does NOT:
• redefine perception itself
• assert belief or cognition
• imply authority or intervention

It is a valuation snapshot only.
###############################################################################
-/

namespace SigmaR

/--
A perception valuation relative to a specific agent and state.
-/
constant PerceptionState :
  Agent → State → PerceptionValuation

end SigmaR
