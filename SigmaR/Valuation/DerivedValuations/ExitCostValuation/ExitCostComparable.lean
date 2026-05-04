import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.DerivedValuations.ExitCostValuation

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

namespace SigmaR

/--
ExitCostComparable E₁ E₂ means that exit cost valuations
E₁ and E₂ are structurally comparable.
-/
constant ExitCostComparable :
  ExitCostValuation → ExitCostValuation → Prop

end SigmaR
