import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.DerivedValuations.CouplingValuation

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

namespace SigmaR

/--
CouplingDependsOnContext C means that coupling valuation C
is explicitly context-dependent.
-/
constant CouplingDependsOnContext :
  CouplingValuation → Prop

end SigmaR
