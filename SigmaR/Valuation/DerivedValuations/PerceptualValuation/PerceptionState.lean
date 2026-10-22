import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.DerivedValuations.PerceptualValuation.PerceptionValuation

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

namespace SigmaR.Valuation.DerivedValuations.PerceptualValuation

/--
A perception valuation relative to a specific agent and state.
-/
axiom PerceptionState :
  Agent → State → PerceptionValuation

end SigmaR.Valuation.DerivedValuations.PerceptualValuation
