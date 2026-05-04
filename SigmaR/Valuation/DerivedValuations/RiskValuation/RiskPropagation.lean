import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.DerivedValuations.RiskValuation.RiskValuation

/-!
###############################################################################
# Risk Propagation
###############################################################################

This file introduces propagation of risk valuation.

Propagation captures the spread of structural risk
through relational or systemic pathways.

It does NOT:
• imply causation
• assign responsibility
• justify intervention
###############################################################################
-/

namespace SigmaR

/--
RiskPropagation R₁ R₂ means that risk valuation R₁
propagates structurally to risk valuation R₂.
-/
constant RiskPropagation :
  RiskValuation → RiskValuation → Prop

end SigmaR
