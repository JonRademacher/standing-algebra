import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.ResponseSemantics.Response
import SigmaR.Valuation.DerivedValuations.RiskValuation.RiskValuation

/-!
###############################################################################
# Risk Depends On Response
###############################################################################

This file introduces structural dependency of risk
valuation on response semantics.

Dependency does NOT imply:
• endorsement of response
• justification of action
• obligation to intervene

It is structural sensitivity only.
###############################################################################
-/

namespace SigmaR

/--
RiskDependsOnResponse R S means that risk valuation R
is structurally sensitive to response S.
-/
constant RiskDependsOnResponse :
  RiskValuation → Response → Prop

end SigmaR
