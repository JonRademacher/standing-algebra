import SigmaR.StandingAlgebra_FormalCore

/-!
###############################################################################
# Measurement Does Not Imply Control
###############################################################################

The ability to measure or observe a system does not
imply the ability to control or influence it.
###############################################################################
-/

namespace SigmaR

/--
Measurement does not license control.
-/
axiom measurement_not_control :
  ¬ (∀ (a : Agent) (s : State),
        True)

end SigmaR
