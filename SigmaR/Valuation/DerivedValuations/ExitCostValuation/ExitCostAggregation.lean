import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.DerivedValuations.ExitCostValuation

/-!
###############################################################################
# Exit Cost Aggregation
###############################################################################

This file introduces aggregation semantics for exit cost
valuations.

Aggregation does NOT imply:
• prioritization
• optimization
• moral evaluation
• legitimacy

It is structural composition only.
###############################################################################
-/

namespace SigmaR

/--
ExitCostAggregation E₁ E₂ E₃ means that exit cost valuation E₃
is an aggregation of exit cost valuations E₁ and E₂.
-/
constant ExitCostAggregation :
  ExitCostValuation → ExitCostValuation → ExitCostValuation → Prop

end SigmaR
