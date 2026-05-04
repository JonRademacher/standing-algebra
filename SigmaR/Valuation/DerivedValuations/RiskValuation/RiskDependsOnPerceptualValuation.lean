import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.DerivedValuations.RiskValuation.RiskValuation
import SigmaR.Valuation.DerivedValuations.PerceptionValuation.PerceptionValuation

/-!
###############################################################################
# Risk Depends On Perceptual Valuation
###############################################################################

This file introduces structural dependency of risk
valuation on perceptual valuation.

This captures that recognition, misalignment, or
misperception of exposure can affect effective risk.

It does NOT:
• equate perception with reality
• imply error
• justify intervention
###############################################################################
-/

namespace SigmaR

/--
RiskDependsOnPerceptualValuation R P means that
risk valuation R is structurally dependent on
perceptual valuation P.
-/
constant RiskDependsOnPerceptualValuation :
  RiskValuation → PerceptionValuation → Prop

end SigmaR
