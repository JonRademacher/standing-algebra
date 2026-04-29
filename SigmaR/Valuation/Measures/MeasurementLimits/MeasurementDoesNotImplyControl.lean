import SigmaR.StandingAlgebra_FormalCore

/-!
###############################################################################
# Measurement Does Not Imply Control
###############################################################################

The ability to measure or observe a system does not
imply the ability to control or influence it.

Observation does not license intervention.
###############################################################################
-/

namespace SigmaR

/--
No implication from measurement to control is permitted.
-/
axiom measurement_not_control :
  ¬ (
    ∀ (a : Agent) (s : State),
      Observable a s →
      Controls a s
  )

end SigmaR

