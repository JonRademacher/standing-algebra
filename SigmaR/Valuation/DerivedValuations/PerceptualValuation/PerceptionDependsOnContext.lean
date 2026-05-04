import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.DerivedValuations.PerceptionValuation

/-!
###############################################################################
# Perception Depends On Context
###############################################################################

This file introduces structural dependency of perception
valuation on context.

Context includes situational, environmental, and
frame-related factors.

Context dependence does NOT imply:
• relativism
• subjectivity
• authority

It is structural scoping only.
###############################################################################
-/

namespace SigmaR

/--
PerceptionDependsOnContext P means that perception valuation P
is explicitly context-dependent.
-/
constant PerceptionDependsOnContext :
  PerceptionValuation → Prop

end SigmaR
