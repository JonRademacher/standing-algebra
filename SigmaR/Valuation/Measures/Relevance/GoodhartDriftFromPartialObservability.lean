import SigmaR.StandingAlgebra_FormalCore

/-!
###############################################################################
# Goodhart Drift From Partial Observability
###############################################################################

When evaluation relies solely on partial observability
(IPFA), collective drift may arise without any local failure.
###############################################################################
-/

namespace SigmaR

/--
Partial observability permits Goodhart drift even
when individual perceptual frames remain internally coherent.
-/
axiom goodhart_drift_from_partial_observability :
  ∃ (M : Agent → State → Nat),
    True

end SigmaR
