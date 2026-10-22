import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.DerivedValuations.StandingValuation.StandingValuation

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

namespace SigmaR.Valuation.DerivedValuations.StandingValuation

/--
StandingCollapse S means that standing valuation S
has structurally collapsed.
-/
axiom StandingCollapse :
  StandingValuation → Prop

end SigmaR.Valuation.DerivedValuations.StandingValuation
