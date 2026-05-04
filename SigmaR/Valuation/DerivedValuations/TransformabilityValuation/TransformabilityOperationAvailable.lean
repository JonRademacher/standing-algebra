import SigmaR.StandingAlgebra_FormalCore

/-!
###############################################################################
# Transformability Operation Available
###############################################################################

This file introduces the notion that a transformation
operation is available for use.

Availability denotes existence, not endorsement
or obligation.

It does NOT:
• imply desirability
• imply selection
• authorize action
###############################################################################
-/

namespace SigmaR

/--
TransformabilityOperationAvailable F means that operation F
is available for transformation.
-/
constant TransformabilityOperationAvailable :
  Operation → Prop

end SigmaR
