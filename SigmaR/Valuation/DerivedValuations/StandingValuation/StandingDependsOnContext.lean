import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.DerivedValuations.StandingValuation

/-!
###############################################################################
# Standing Depends On Context
###############################################################################

This file introduces structural dependency of standing valuation
on context.

Context dependence does NOT imply:
• relativism
• subjectivity
• authority
###############################################################################
-/

namespace SigmaR

/--
StandingDependsOnContext S means that standing valuation S
is explicitly context-dependent.
-/
constant StandingDependsOnContext :
  StandingValuation → Prop

end SigmaR
