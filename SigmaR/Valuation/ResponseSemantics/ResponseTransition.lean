import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.ResponseSemantics.Response

/-!
###############################################################################
# Response Transition
###############################################################################

This file defines how a response maps one state to another.

The transition relation does NOT imply:
• causation
• necessity
• authorization
• temporal dynamics

It is a purely structural mapping.
###############################################################################
-/

namespace SigmaR

/--
A response induces a transition between states.
-/
constant ResponseTransition :
  Response → State → State → Prop

end SigmaR
