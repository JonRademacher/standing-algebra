import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.DerivedValuations.ExitCostValuation

/-!
###############################################################################
# Exit Cost Collapse
###############################################################################

This file introduces the structural notion of collapse
in exit cost valuation.

Collapse does NOT imply:
• moral failure
• responsibility
• obligation to respond
• authority to intervene

It is a valuation-level condition only.
###############################################################################
-/

namespace SigmaR

/--
ExitCostCollapse E means that exit cost valuation E
has structurally collapsed.
-/
constant ExitCostCollapse :
  ExitCostValuation → Prop

end SigmaR
