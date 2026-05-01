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
constant Operation : Type

/--
Application of an operation to an agent.
-/
constant Apply : Operation → Agent → Agent

end SigmaR
