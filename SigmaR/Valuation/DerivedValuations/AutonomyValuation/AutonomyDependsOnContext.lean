import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.DerivedValuations.AutonomyValuation

/-!
###############################################################################
# Autonomy Depends On Context
###############################################################################

This file introduces the structural dependency of autonomy
valuation on context.

Context dependence does NOT imply:
• relativism
• subjectivity
• authority

It is structural scoping only.
###############################################################################
-/

namespace SigmaR

/--
AutonomyDependsOnContext A means that autonomy valuation A
is explicitly context-dependent.
-/
constant AutonomyDependsOnContext :
  AutonomyValuation → Prop

end SigmaR
