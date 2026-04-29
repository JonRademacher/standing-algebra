import SigmaR.StandingAlgebra_FormalCore

/-!
###############################################################################
# No Perfect Measurement
###############################################################################

No measurement is assumed to perfectly capture
the full state or value of a measure.
###############################################################################
-/

namespace SigmaR

/--
Perfect measurement is not assumed.
-/
axiom no_perfect_measurement :
  ∀ (a : Agent) (s : State),
    True

end SigmaR
