import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.DerivedValuations.RiskValuation.RiskValuation

/-!
###############################################################################
# Risk Exposure
###############################################################################

This file introduces the notion of exposure in risk valuation.

Exposure represents structural susceptibility to harm
or constraint under given conditions.

It does NOT:
• imply fault
• imply likelihood beliefs
• assert causation
###############################################################################
-/

namespace SigmaR

/--
RiskExposure R means that risk valuation R
includes structural exposure.
-/
constant RiskExposure :
  RiskValuation → Prop

end SigmaR
