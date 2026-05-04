import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.DerivedValuations.CapacityValuation.CapacityValuation
import SigmaR.Valuation.DerivedValuations.CapacityValuation.CapacityAgreement

/-!
###############################################################################
# Capacity Comparable Under Agreement
###############################################################################

This file introduces comparability of capacity valuations
conditioned on a specific capacity agreement.

This captures that some comparisons are only meaningful
relative to an agreement locus (internal or external).

It does NOT:
• privilege consensus
• override personal warrant
• assert correctness
###############################################################################
-/

namespace SigmaR

/--
CapacityComparableUnderAgreement C₁ C₂ A means that
capacity valuations C₁ and C₂ are structurally comparable
under capacity agreement A.
-/
constant CapacityComparableUnderAgreement :
  CapacityValuation → CapacityValuation → CapacityAgreement → Prop

end SigmaR
