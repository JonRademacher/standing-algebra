import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.DerivedValuations.CouplingValuation.CouplingValuation

/-!
###############################################################################
# Coupling Depends On Context
###############################################################################

This file introduces structural dependency of coupling valuation
on context.

Context dependence does NOT imply:
• relativism
• subjectivity
• authority

It is structural scoping only.
###############################################################################
-/

namespace SigmaR.Valuation.DerivedValuations.CouplingValuation

/--
CouplingDependsOnContext C means that coupling valuation C
is explicitly context-dependent.
-/
axiom CouplingDependsOnContext :
  CouplingValuation → Prop

end SigmaR.Valuation.DerivedValuations.CouplingValuation
