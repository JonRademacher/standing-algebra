import SigmaR.StandingAlgebra_FormalCore

/-!
###############################################################################
# Equivalence Does Not Permit Optimization
###############################################################################

Equivalence between valuation measures does not
license optimization or maximization.
###############################################################################
-/

namespace SigmaR

/--
Equivalence does not imply optimizability.
-/
axiom equivalence_not_optimization :
  ¬ (∃ (O : State → Nat),
        True)

end SigmaR
