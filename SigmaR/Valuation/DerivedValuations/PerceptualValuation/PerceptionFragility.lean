import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.DerivedValuations.PerceptionValuation

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

namespace SigmaR

/--
PerceptionFragility P means that perception valuation P
is structurally sensitive to certain changes.
-/
constant PerceptionFragility :
  PerceptionValuation → Prop

end SigmaR
