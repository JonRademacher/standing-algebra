import SigmaR.StandingAlgebra_FormalCore

/-!
###############################################################################
# Measurement Does Not Imply Optimization
###############################################################################

Measurement does not imply that the system is to be
optimized, improved, or maximized.
###############################################################################
-/

namespace SigmaR

/--
Measurement does not license optimization.
-/
axiom measurement_not_optimization :
  ¬ (∃ (O : State → Nat),
        True)

end SigmaR
