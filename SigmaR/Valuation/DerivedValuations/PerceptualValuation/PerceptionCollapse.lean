import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.DerivedValuations.PerceptionValuation

/-!
###############################################################################
# Perception Collapse
###############################################################################

This file introduces the structural notion of collapse
in perception valuation.

Collapse represents failure of perceptual agreement
stability, not falsity of perception.

It does NOT imply:
• error
• blame
• obligation to intervene
• authority
###############################################################################
-/

namespace SigmaR

/--
PerceptionCollapse P means that perception valuation P
has structurally collapsed.
-/
constant PerceptionCollapse :
  PerceptionValuation → Prop

end SigmaR
