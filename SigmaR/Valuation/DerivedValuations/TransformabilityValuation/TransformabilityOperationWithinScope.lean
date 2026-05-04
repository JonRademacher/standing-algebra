import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.DerivedValuations.TransformabilityValuation.TransformabilityOperationSet

/-!
###############################################################################
# Transformability Operation Within Scope
###############################################################################

This file introduces the notion that a transformation
operation lies within effective scope of use.

Scope captures feasibility and control, not preference.

It does NOT:
• imply endorsement
• imply obligation
• assert authority
###############################################################################
-/

namespace SigmaR

/--
TransformabilityOperationWithinScope S means that operations
in S lie within effective scope of transformation.
-/
constant TransformabilityOperationWithinScope :
  TransformabilityOperationSet → Prop

end SigmaR
