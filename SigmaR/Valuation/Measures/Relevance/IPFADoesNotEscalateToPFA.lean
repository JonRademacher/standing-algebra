import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Core.StructuralInterfaces

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
No implication permitting IPFA alone to establish
PFA or collective warrant is allowed.
-/
axiom ipfa_not_escalate_to_pfa :
  ¬ (
    ∀ (G : Set Agent) (s : State),
      (∀ a ∈ G, IPFA a s) →
      PFA G s
  )

end SigmaR

