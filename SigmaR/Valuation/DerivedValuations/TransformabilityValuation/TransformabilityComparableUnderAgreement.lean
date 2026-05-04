import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.DerivedValuations.TransformabilityValuation.TransformabilityValuation
import SigmaR.Valuation.DerivedValuations.TransformabilityValuation.TransformabilityAgreement

/-!
###############################################################################
# Transformability Comparable Under Agreement
###############################################################################

This file introduces comparability of transformability valuations
conditioned on a specific transformability agreement.

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
TransformabilityComparableUnderAgreement T₁ T₂ A means that
transformability valuations T₁ and T₂ are structurally comparable
under transformability agreement A.
-/
constant TransformabilityComparableUnderAgreement :
  TransformabilityValuation → TransformabilityValuation → TransformabilityAgreement → Prop

end SigmaR
