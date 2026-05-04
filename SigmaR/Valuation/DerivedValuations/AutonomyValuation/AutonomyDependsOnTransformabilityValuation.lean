import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.DerivedValuations.AutonomyValuation.AutonomyValuation
import SigmaR.Valuation.DerivedValuations.TransformabilityValuation.TransformabilityValuation

/-!
###############################################################################
# Autonomy Depends On Transformability Valuation
###############################################################################

This file introduces structural dependency of autonomy
valuation on transformability valuation.

This captures that effective autonomy depends on the
ability to alter constraints and state through available
transformations.

It does NOT:
• imply competence
• imply responsibility
• assert entitlement
###############################################################################
-/

namespace SigmaR

/--
AutonomyDependsOnTransformabilityValuation A T means that
autonomy valuation A is structurally dependent on
transformability valuation T.
-/
constant AutonomyDependsOnTransformabilityValuation :
  AutonomyValuation → TransformabilityValuation → Prop

end SigmaR
