import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.DerivedValuations.TransformabilityValuation.TransformabilityValuation

/-!
###############################################################################
# Transformability Depends On Context
###############################################################################

This file introduces structural dependency of transformability
valuation on context.

Context includes situational, environmental, temporal,
and structural conditions.

Context dependence does NOT imply:
• subjectivity
• relativism
• authority
###############################################################################
-/

namespace SigmaR.Valuation.DerivedValuations.TransformabilityValuation

/--
TransformabilityDependsOnContext T means that transformability
valuation T is explicitly context-dependent.
-/
axiom TransformabilityDependsOnContext :
  TransformabilityValuation → Prop

end SigmaR.Valuation.DerivedValuations.TransformabilityValuation
