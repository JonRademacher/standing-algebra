import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.DerivedValuations.CapacityValuation
import SigmaR.Valuation.DerivedValuations.PerceptualValuation.PerceptionValuation

/-!
###############################################################################
# Capacity Depends On Perception Valuation
###############################################################################

This file introduces structural dependency of capacity
valuation on perceptual valuation.

This captures the fact that usable capacity is mediated
by perceived feasibility, recognition, and frame-stabilized
assessment, without collapsing perception into authority.

It does NOT:
• equate perception with reality
• imply correctness
• imply selection
###############################################################################
-/

namespace SigmaR

/--
CapacityDependsOnPerceptionValuation C P means that capacity
valuation C is structurally dependent on perception valuation P.
-/
constant CapacityDependsOnPerceptionValuation :
  CapacityValuation → PerceptionValuation → Prop

end SigmaR
