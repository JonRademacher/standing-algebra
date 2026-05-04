import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.DerivedValuations.TransformabilityValuation.TransformabilityValuation

/-!
###############################################################################
# Transformability Valuation Admissible
###############################################################################

This file introduces admissibility constraints for
transformability valuation.

Admissibility governs whether a transformability valuation
may be used in reasoning.

It does NOT:
• imply correctness
• imply competence or creativity
• authorize intervention or action
###############################################################################
-/

namespace SigmaR

/--
TransformabilityValuationAdmissible T means that
transformability valuation T is admissible under
declared structural constraints.
-/
constant TransformabilityValuationAdmissible :
  TransformabilityValuation → Prop

end SigmaR
