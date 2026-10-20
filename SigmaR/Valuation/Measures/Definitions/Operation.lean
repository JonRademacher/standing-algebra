import SigmaR.StandingAlgebra_FormalCore

/-!
###############################################################################
# Operation
###############################################################################

This file introduces abstract operations that may transform agents.

Operations are structural and uninterpreted.
###############################################################################
-/

namespace SigmaR

/--
An abstract operation acting on agents.
-/
axiom Operation : Type

/--
Application of an operation to an agent.
-/
axiom Apply : Operation → Agent → Agent

end SigmaR
