import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.DerivedValuations.TransformabilityValuation.TransformabilityValuation

/-!
###############################################################################
# Transformability Fragility
###############################################################################

This file introduces fragility in transformability valuation.

Fragility represents sensitivity to structural or contextual
change, not weakness or failure.

It does NOT:
• imply lack of ability in principle
• imply unreliability
• imply fault
###############################################################################
-/

namespace SigmaR

/--
TransformabilityFragility T means that transformability valuation T
is structurally fragile.
-/
constant TransformabilityFragility :
  TransformabilityValuation → Prop

end SigmaR
