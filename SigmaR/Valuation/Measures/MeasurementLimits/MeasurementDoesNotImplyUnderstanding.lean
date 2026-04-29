import SigmaR.StandingAlgebra_FormalCore

/-!
###############################################################################
# Measurement Does Not Imply Understanding
###############################################################################

Having measurements does not imply understanding
of causes, structure, or meaning.

Observation does not license understanding.
###############################################################################
-/

namespace SigmaR

/--
No implication from measurement to understanding is permitted.
-/
axiom measurement_not_understanding :
  ¬ (
    ∀ (a : Agent) (s : State),
      Observable a s →
      Understands a s
  )

end SigmaR
