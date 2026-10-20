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

/-!
The sorts `Agent` and `Operation` and the effect function `apply` are
primitives of the formal core
(`SigmaR/StandingAlgebra_FormalCore.lean`): the operation layer is a *layer*
over that core, not a second declaration of it.
-/

/--
State-level application: `Apply F s` is the configuration reached from `s` by
applying `F`.  Since `State` and `Agent` are the same carrier, this is the
core `apply`, presented with the state in the first argument position.
-/
axiom Apply : Operation → State → State

end SigmaR
