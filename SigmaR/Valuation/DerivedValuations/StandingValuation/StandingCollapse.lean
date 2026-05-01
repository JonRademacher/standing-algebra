import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.DerivedValuations.StandingValuation

/-!
###############################################################################
# Standing Collapse
###############################################################################

This file introduces the structural notion of collapse
in standing valuation.

Collapse does NOT imply:
• moral failure
• responsibility
• obligation to repair
• authority to intervene

It is a valuation-level condition only.
###############################################################################
-/

namespace SigmaR

/--
StandingCollapse S means that standing valuation S
has structurally collapsed.
-/
constant StandingCollapse :
  StandingValuation → Prop

end SigmaR
