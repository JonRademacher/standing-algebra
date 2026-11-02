import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.DerivedValuations.StandingValuation.StandingValuation

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

namespace SigmaR.Valuation.DerivedValuations.StandingValuation

/--
StandingDependsOnContext S means that standing valuation S
is explicitly context-dependent.
-/
axiom StandingDependsOnContext :
  StandingValuation → Prop

end SigmaR.Valuation.DerivedValuations.StandingValuation
