import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.DerivedValuations.CapacityValuation.CapacityValuation

/-!
###############################################################################
# Capacity State
###############################################################################

This file introduces capacity valuation as a state-relative
derived valuation.

It represents a snapshot of effective capacity for an agent
in a given state.

It does NOT:
• redefine structural capacity
• assert correctness of assessment
• imply authority
###############################################################################
-/

namespace SigmaR.Valuation.DerivedValuations.CapacityValuation

/--
A capacity valuation relative to a specific agent and state.
-/
axiom CapacityState :
  Agent → State → CapacityValuation

end SigmaR.Valuation.DerivedValuations.CapacityValuation
