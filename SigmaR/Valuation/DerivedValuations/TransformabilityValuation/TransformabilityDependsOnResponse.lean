import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.ResponseSemantics.Response
import SigmaR.Valuation.DerivedValuations.TransformabilityValuation.TransformabilityValuation

/-!
###############################################################################
# Transformability Depends On Response
###############################################################################

This file introduces structural dependency of transformability
valuation on response semantics.

Dependency does NOT imply:
• endorsement of response
• obligation to act
• justification of intervention
###############################################################################
-/

namespace SigmaR

/--
TransformabilityDependsOnResponse T R means that transformability
valuation T is structurally sensitive to response R.
-/
constant TransformabilityDependsOnResponse :
  TransformabilityValuation → Response → Prop

end SigmaR
