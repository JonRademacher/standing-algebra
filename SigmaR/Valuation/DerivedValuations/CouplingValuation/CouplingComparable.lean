import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.DerivedValuations.CouplingValuation.CouplingValuation

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

namespace SigmaR.Valuation.DerivedValuations.CouplingValuation

/--
CouplingComparable C₁ C₂ means that coupling valuations
C₁ and C₂ are structurally comparable.
-/
axiom CouplingComparable :
  CouplingValuation → CouplingValuation → Prop

end SigmaR.Valuation.DerivedValuations.CouplingValuation
