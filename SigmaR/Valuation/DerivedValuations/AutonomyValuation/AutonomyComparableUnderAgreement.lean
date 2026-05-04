import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.DerivedValuations.AutonomyValuation.AutonomyValuation
import SigmaR.Valuation.DerivedValuations.AutonomyValuation.AutonomyAgreement

/-!
###############################################################################
# Autonomy Comparable Under Agreement
###############################################################################

This file introduces comparability of autonomy valuations
conditioned on a specific autonomy agreement.

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
AutonomyComparableUnderAgreement A₁ A₂ G means that
autonomy valuations A₁ and A₂ are structurally comparable
under autonomy agreement G.
-/
constant AutonomyComparableUnderAgreement :
  AutonomyValuation → AutonomyValuation → AutonomyAgreement → Prop

end SigmaR
