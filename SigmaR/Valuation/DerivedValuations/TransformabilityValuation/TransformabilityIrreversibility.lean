import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.DerivedValuations.TransformabilityValuation.TransformabilityValuation

/-!
###############################################################################
# Transformability Irreversibility
###############################################################################

This file introduces irreversibility in transformability valuation.

Irreversibility captures cases where degradation of
transformability cannot be undone within the current
structural regime.

It does NOT:
• assert permanence in principle
• authorize intervention
• imply moral judgment
###############################################################################
-/

namespace SigmaR

/--
TransformabilityIrreversibility T means that transformability
valuation T is structurally irreversible once degraded.
-/
constant TransformabilityIrreversibility :
  TransformabilityValuation → Prop

end SigmaR
