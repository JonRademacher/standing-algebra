import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.DerivedValuations.ExitCostValuation

/-!
###############################################################################
# Exit Cost Irreversibility
###############################################################################

This file introduces irreversibility specific to
exit cost valuations.

Irreversibility does NOT imply:
• prohibition of exit
• moral finality
• authority to act

It is descriptive only.
###############################################################################
-/

namespace SigmaR

/--
ExitCostIrreversibility E means that exit cost valuation E
is structurally irreversible once accumulated or lost.
-/
constant ExitCostIrreversibility :
  ExitCostValuation → Prop

end SigmaR
