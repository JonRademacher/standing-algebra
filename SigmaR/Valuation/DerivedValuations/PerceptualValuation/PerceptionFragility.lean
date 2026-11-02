import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.DerivedValuations.PerceptualValuation.PerceptionValuation

/-!
###############################################################################
# Perception Fragility
###############################################################################

This file introduces the structural notion of fragility
for perception valuation.

Fragility describes sensitivity to contextual or structural
change, not weakness or unreliability.

It does NOT:
• imply irrationality
• imply moral deficiency
###############################################################################
-/

namespace SigmaR.Valuation.DerivedValuations.PerceptualValuation

/--
PerceptionFragility P means that perception valuation P
is structurally sensitive to certain changes.
-/
axiom PerceptionFragility :
  PerceptionValuation → Prop

end SigmaR.Valuation.DerivedValuations.PerceptualValuation
