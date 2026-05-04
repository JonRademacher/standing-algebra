import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.DerivedValuations.TransformabilityValuation.TransformabilityValuation

/-!
###############################################################################
# Transformability Collapse
###############################################################################

This file introduces collapse in transformability valuation.

Collapse represents a regime where effective ability to
transform state falls below viability for intended roles.

It does NOT:
• imply fault
• imply incompetence
• authorize intervention
###############################################################################
-/

namespace SigmaR

/--
TransformabilityCollapse T means that transformability valuation T
has structurally collapsed.
-/
constant TransformabilityCollapse :
  TransformabilityValuation → Prop

end SigmaR
