import SigmaR.StandingAlgebra_FormalCore

/-!
###############################################################################
# IPFA Does Not Escalate to PFA
###############################################################################

Internalized Perceptual Frame Agreement (IPFA)
does not by itself establish Perceptual Frame Agreement (PFA).
###############################################################################
-/

namespace SigmaR

/--
IPFA does not escalate to PFA without shared observation.
-/
axiom ipfa_not_escalate_to_pfa :
  ∀ (P : Agent → State → Prop),
    ¬ (∀ a s, P a s) →
    ¬ (∀ s, True)

end SigmaR
