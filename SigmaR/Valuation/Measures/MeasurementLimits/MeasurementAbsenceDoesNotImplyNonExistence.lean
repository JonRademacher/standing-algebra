import SigmaR.StandingAlgebra_FormalCore

/-!
###############################################################################
# Measurement Absence Does Not Imply Non-Existence
###############################################################################

The absence of measurement or observation does not imply
that a state, property, or condition does not exist.

Measurement limits constrain access, not reality.
###############################################################################
-/

namespace SigmaR

/--
Failure to observe does not imply non-existence.
-/
axiom measurement_absence_not_nonexistence :
  ∀ (a : Agent) (s : State),
    ¬ True → True

end SigmaR
