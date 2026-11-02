import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.DerivedValuations.PerceptualValuation.PerceptionValuation

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

namespace SigmaR.Valuation.DerivedValuations.PerceptualValuation

/--
PerceptionCollapse P means that perception valuation P
has structurally collapsed.
-/
axiom PerceptionCollapse :
  PerceptionValuation → Prop

end SigmaR.Valuation.DerivedValuations.PerceptualValuation
