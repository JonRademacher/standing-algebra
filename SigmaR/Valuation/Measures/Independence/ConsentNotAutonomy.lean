import SigmaR.StandingAlgebra_FormalCore

/-!
###############################################################################
# Consent ≠ Autonomy (Measure Independence)
###############################################################################

Consent does not constitute autonomy.
###############################################################################
-/

namespace SigmaR

/--
Consent is not definitionally reducible to autonomy.
-/
axiom ConsentNotAutonomy :
  ¬ (∀ (i : Agent) (s : State),
      Consent i s → Autonomous i s)

end SigmaR
