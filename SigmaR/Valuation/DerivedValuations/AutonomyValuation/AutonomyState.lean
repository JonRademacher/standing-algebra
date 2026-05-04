import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.DerivedValuations.AutonomyValuation

/-!
###############################################################################
# Autonomy State
###############################################################################

This file introduces autonomy as a state-relative valuation.

Autonomy state does NOT:
• imply agency
• imply authority
• imply intervention
• imply moral standing

It is a snapshot of valuation only.
###############################################################################
-/

namespace SigmaR

/--
An autonomy valuation relative to a specific state.
-/
constant AutonomyState :
  Agent → State → AutonomyValuation

end SigmaR
