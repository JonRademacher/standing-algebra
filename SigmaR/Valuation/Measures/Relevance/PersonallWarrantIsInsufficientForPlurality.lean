import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Core.StructuralInterfaces

/-!
###############################################################################
# Personal Warrant Is Insufficient for Plurality
###############################################################################

Individual personal warrants do not, by themselves,
constitute collective perceptual agreement.
###############################################################################
-/

namespace SigmaR

/--
No implication reducing PFA to a conjunction
of IPFAs is permitted.
-/
axiom ipfa_insufficient_for_pfa :
  ¬ (
    ∀ (G : Set Agent) (s : State),
      PFA G s →
      (∀ a ∈ G, IPFA a s)
  )

end SigmaR
