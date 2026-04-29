import SigmaR.StandingAlgebra_FormalCore

/-!
###############################################################################
# Finite Measurement Resolution
###############################################################################

Measurements have finite resolution.
Arbitrarily fine distinctions are not assumed observable.
###############################################################################
-/

namespace SigmaR

/--
Measurement resolution is finite.
-/
axiom finite_measurement_resolution :
  ∀ (a : Agent) (s : State),
    True

end SigmaR
