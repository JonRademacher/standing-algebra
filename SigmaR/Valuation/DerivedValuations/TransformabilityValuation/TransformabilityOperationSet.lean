import SigmaR.StandingAlgebra_FormalCore

/-!
###############################################################################
# Transformability Operation Set
###############################################################################

This file introduces sets of available transformation operations.

Operation sets define the feasible transformation space.

They do NOT:
• impose preference
• imply optimization
• assert completeness
###############################################################################
-/

namespace SigmaR

/--
TransformabilityOperationSet S means that S is a set
of transformation operations.
-/
constant TransformabilityOperationSet :
  Operation → Prop

end SigmaR
