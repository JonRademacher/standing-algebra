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
No implication from lack of observation to non-existence
is permitted.
-/
axiom measurement_absence_not_nonexistence :
  ¬ (
    ∀ (a : Agent) (s : State),
      ¬ Observable a s → ¬ Exists s
  )

end SigmaR

