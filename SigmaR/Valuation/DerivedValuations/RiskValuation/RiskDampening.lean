import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.DerivedValuations.RiskValuation.RiskValuation

/-!
###############################################################################
# Risk Dampening
###############################################################################

This file introduces dampening of risk valuation.

Dampening captures structural conditions under which
risk exposure is reduced or buffered.

It does NOT:
• imply resolution of risk
• imply safety guarantees
• authorize intervention
###############################################################################
-/

namespace SigmaR

/--
RiskDampening R₁ R₂ means that risk valuation R₁
dampens the effective risk represented by R₂.
-/
constant RiskDampening :
  RiskValuation → RiskValuation → Prop

end SigmaR
