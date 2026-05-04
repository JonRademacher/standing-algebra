import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.DerivedValuations.RiskValuation.RiskValuation

/-!
###############################################################################
# Risk Aggregation
###############################################################################

This file introduces aggregation semantics for risk valuation.

Aggregation represents structural combination of risk exposure
across sources, contexts, or relationships.

It does NOT:
• imply responsibility
• imply prioritization
• justify mitigation
###############################################################################
-/

namespace SigmaR

/--
RiskAggregation R₁ R₂ R₃ means that risk valuation R₃
is an aggregation of risk valuations R₁ and R₂.
-/
constant RiskAggregation :
  RiskValuation → RiskValuation → RiskValuation → Prop

end SigmaR
