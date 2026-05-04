import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.DerivedValuations.PerceptionValuation

/-!
###############################################################################
# Perception Divergence
###############################################################################

This file introduces the structural notion of divergence
in perception valuation.

Divergence captures increasing separation between
perceptual alignments over time or context.

It does NOT imply:
• error
• irrationality
• moral fault
###############################################################################
-/

namespace SigmaR

/--
PerceptionDivergence P₁ P₂ means that perception valuation P₁
and P₂ are structurally diverging.
-/
constant PerceptionDivergence :
  PerceptionValuation → PerceptionValuation → Prop

end SigmaR
