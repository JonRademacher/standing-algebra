import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Core.StructuralInterfaces

/-!
###############################################################################
# Personal Relevance Does Not Imply System Relevance
###############################################################################

Relevance sufficient for personal action does not
establish relevance for collective or system-level evaluation.
###############################################################################
-/

namespace SigmaR

/--
No implication permitting personal relevance to
escalate to system-level relevance or authority
is allowed.
-/
axiom personal_not_system_relevance :
  ¬ (
    ∀ (a : Agent) (s : State),
      IPFA a s →
      TreatedAsAuthoritative s
  )

end SigmaR
