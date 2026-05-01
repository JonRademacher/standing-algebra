import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.DerivedValuations.AutonomyValuation

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

namespace SigmaR

/--
AutonomyComparable A₁ A₂ means that autonomy valuations
A₁ and A₂ are structurally comparable.
-/
constant AutonomyComparable :
  AutonomyValuation → AutonomyValuation → Prop

end SigmaR
