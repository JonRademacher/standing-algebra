import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.DerivedValuations.ExitCostValuation.ExitCostValuation

/-!
###############################################################################
# Exit Cost Comparable
###############################################################################

This file introduces comparability semantics
specific to exit cost valuations.

Comparability does NOT imply:
• ranking
• priority
• authority
• justification for action

It is structural only.
###############################################################################
-/

namespace SigmaR.Valuation.DerivedValuations.ExitCostValuation

/--
ExitCostComparable E₁ E₂ means that exit cost valuations
E₁ and E₂ are structurally comparable.
-/
axiom ExitCostComparable :
  ExitCostValuation → ExitCostValuation → Prop

end SigmaR.Valuation.DerivedValuations.ExitCostValuation
