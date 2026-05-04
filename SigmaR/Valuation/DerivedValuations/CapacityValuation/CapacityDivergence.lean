import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.DerivedValuations.CapacityValuation.CapacityValuation

/-!
###############################################################################
# Capacity Divergence
###############################################################################

This file introduces divergence in capacity valuation.

Divergence captures increasing separation between
capacity valuations across time, context, or agreement loci.

It does NOT imply:
• error
• misjudgment
• normative deficiency
###############################################################################
-/

namespace SigmaR

/--
CapacityDivergence C₁ C₂ means that capacity valuations
C₁ and C₂ are structurally diverging.
-/
constant CapacityDivergence :
  CapacityValuation → CapacityValuation → Prop

end SigmaR
