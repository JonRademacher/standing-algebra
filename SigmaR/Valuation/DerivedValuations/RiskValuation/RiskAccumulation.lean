import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.DerivedValuations.RiskValuation.RiskValuation

/-!
###############################################################################
# Risk Accumulation
###############################################################################

This file introduces accumulation in risk valuation.

Accumulation represents increase of risk load
over time or through repeated exposure.

It does NOT:
• imply wrongdoing
• assert negligence
• justify intervention
###############################################################################
-/

namespace SigmaR.Valuation.DerivedValuations.RiskValuation

/--
RiskAccumulation R₁ R₂ means that risk valuation R₂
represents accumulated risk relative to R₁.
-/
axiom RiskAccumulation :
  RiskValuation → RiskValuation → Prop

end SigmaR.Valuation.DerivedValuations.RiskValuation
