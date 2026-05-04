import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.DerivedValuations.TransformabilityValuation.TransformabilityValuation

/-!
###############################################################################
# Transformability State
###############################################################################

This file introduces transformability valuation as a
state-relative derived valuation.

It represents a snapshot of effective transformability
for an agent in a given state.

It does NOT:
• redefine operations
• assert correctness of capability
• imply authority
###############################################################################
-/

namespace SigmaR

/--
A transformability valuation relative to a specific agent and state.
-/
constant TransformabilityState :
  Agent → State → TransformabilityValuation

end SigmaR
