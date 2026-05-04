import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.DerivedValuations.RiskValuation.RiskValuation

/-!
###############################################################################
# Risk Amplification
###############################################################################

This file introduces amplification of risk valuation.

Amplification captures structural conditions under which
existing risk exposure is intensified.

It does NOT:
• imply blame
• assert intent
• justify mitigation
###############################################################################
-/

namespace SigmaR

/--
RiskAmplification R₁ R₂ means that risk valuation R₁
amplifies the effective risk represented by R₂.
-/
constant RiskAmplification :
  RiskValuation → RiskValuation → Prop

end SigmaR
