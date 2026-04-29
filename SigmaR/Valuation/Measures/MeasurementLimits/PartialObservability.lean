import SigmaR.StandingAlgebra_FormalCore

/-!
###############################################################################
# Partial Observability
###############################################################################

Not all aspects of the system are observable
by any agent at any time.
###############################################################################
-/

namespace SigmaR

/--
Observability is partial.
-/
axiom partial_observability :
  ∃ (a : Agent) (s : State),
    True

end SigmaR
