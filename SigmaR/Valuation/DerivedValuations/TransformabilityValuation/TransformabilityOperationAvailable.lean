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

namespace SigmaR.Valuation.DerivedValuations.TransformabilityValuation

/--
TransformabilityOperationAvailable F means that operation F
is available for transformation.
-/
axiom TransformabilityOperationAvailable :
  Operation → Prop

end SigmaR.Valuation.DerivedValuations.TransformabilityValuation
