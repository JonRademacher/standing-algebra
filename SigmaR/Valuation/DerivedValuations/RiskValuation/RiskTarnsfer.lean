import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.DerivedValuations.RiskValuation.RiskValuation

/-!
###############################################################################
# Risk Transfer
###############################################################################

This file introduces transfer of risk valuation.

Risk transfer represents structural shifting of exposure
between agents or subsystems.

It does NOT:
• imply consent
• imply legitimacy
• assert blame
###############################################################################
-/

namespace SigmaR.Valuation.DerivedValuations.RiskValuation

/--
RiskTransfer R₁ R₂ means that risk valuation R₁
is structurally transferred to R₂.
-/
axiom RiskTransfer :
  RiskValuation → RiskValuation → Prop

end SigmaR.Valuation.DerivedValuations.RiskValuation
