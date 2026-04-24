import SigmaR.StandingAlgebra_FormalCore

/-!
###############################################################################
# Autonomy ≠ Consent (Measure Independence)
###############################################################################

Autonomy does not imply consent.
###############################################################################
-/

namespace SigmaR

/--
Autonomy does not entail consent.
-/
axiom AutonomyNotConsent :
  ¬ (∀ (i : Agent) (s : State),
      Autonomous i s → Consent i s)

end SigmaR
