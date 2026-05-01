import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.DerivedValuations.CouplingValuation
import SigmaR.Valuation.ResponseSemantics.Response

/-!
###############################################################################
# Coupling Depends On Response
###############################################################################

This file introduces structural dependency of coupling valuation
on response semantics.

Dependency does NOT imply:
• authorization of response
• desirability of response
• intervention

It is structural sensitivity only.
###############################################################################
-/

namespace SigmaR

/--
CouplingDependsOnResponse C R means that coupling valuation C
is structurally sensitive to response R.
-/
constant CouplingDependsOnResponse :
  CouplingValuation → Response → Prop

end SigmaR
