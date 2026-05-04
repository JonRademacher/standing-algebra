import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.DerivedValuations.TransformabilityValuation.TransformabilityValuation

/-!
###############################################################################
# Transformability Depends On Operation
###############################################################################

This file introduces structural dependency of transformability
valuation on available operations.

Dependency does NOT imply:
• desirability of operations
• preference ordering
• optimization or selection

It names feasibility only.
###############################################################################
-/

namespace SigmaR

/--
TransformabilityDependsOnOperation T F means that transformability
valuation T is structurally dependent on operation F.
-/
constant TransformabilityDependsOnOperation :
  TransformabilityValuation → Operation → Prop

end SigmaR
