import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.DerivedValuations.ExitCostValuation.ExitCostValuation

/-!
###############################################################################
# Exit Cost Accumulation
###############################################################################

This file introduces the structural notion of accumulation
for exit cost valuations.

Accumulation does NOT imply:
• inevitability
• coercion
• obligation to intervene

It is descriptive only.
###############################################################################
-/

namespace SigmaR.Valuation.DerivedValuations.ExitCostValuation

/--
ExitCostAccumulation E₁ E₂ means that exit cost valuation E₂
represents an accumulation relative to exit cost valuation E₁.
-/
axiom ExitCostAccumulation :
  ExitCostValuation → ExitCostValuation → Prop

end SigmaR.Valuation.DerivedValuations.ExitCostValuation
