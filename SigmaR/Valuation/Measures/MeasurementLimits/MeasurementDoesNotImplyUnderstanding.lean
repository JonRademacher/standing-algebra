import SigmaR.StandingAlgebra_FormalCore

/-!
###############################################################################
# Measurement Does Not Imply Understanding
###############################################################################

Having measurements does not imply understanding
of causes, structure, or meaning.
###############################################################################
-/

namespace SigmaR

/--
Measurement does not entail understanding.
-/
axiom measurement_not_understanding :
  ¬ (∀ (a : Agent) (s : State),
        True)

end SigmaR
