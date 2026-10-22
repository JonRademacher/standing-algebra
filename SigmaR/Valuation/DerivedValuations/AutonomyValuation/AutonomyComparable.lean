import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.DerivedValuations.AutonomyValuation.AutonomyValuation

/-!
###############################################################################
# Autonomy Comparable
###############################################################################

This file introduces comparability semantics
specific to autonomy valuations.

Comparability does NOT imply:
• moral ranking
• authority
• justification for action

It is structural only.
###############################################################################
-/

namespace SigmaR.Valuation.DerivedValuations.AutonomyValuation

/--
AutonomyComparable A₁ A₂ means that autonomy valuations
A₁ and A₂ are structurally comparable.
-/
axiom AutonomyComparable :
  AutonomyValuation → AutonomyValuation → Prop

end SigmaR.Valuation.DerivedValuations.AutonomyValuation
