import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Core.StructuralInterfaces

/-!
###############################################################################
# PFA Is Not Reducible to IPFA
###############################################################################

Collective perceptual agreement is not reducible
to a collection of individual personal warrants.
###############################################################################
-/

namespace SigmaR

/--
No implication identifying or reducing PFA
to a conjunction of IPFAs is permitted.
-/
axiom pfa_not_reducible_to_ipfa :
  ¬ (
    ∀ (G : Set Agent) (s : State),
      PFA G s ↔ (∀ a ∈ G, IPFA a s)
  )

end SigmaR
