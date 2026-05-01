import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.DerivedValuations.CouplingValuation

/-!
###############################################################################
# Coupling Comparable
###############################################################################

This file introduces comparability semantics
specific to coupling valuations.

Comparability does NOT imply:
• ranking
• priority
• authority
• justification for action

It is structural only.
###############################################################################
-/

namespace SigmaR

/--
CouplingComparable C₁ C₂ means that coupling valuations
C₁ and C₂ are structurally comparable.
-/
constant CouplingComparable :
  CouplingValuation → CouplingValuation → Prop

end SigmaR
