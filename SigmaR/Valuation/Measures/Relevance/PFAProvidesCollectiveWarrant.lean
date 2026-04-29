import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Core.StructuralInterfaces

/-!
###############################################################################
# PFA Provides Collective Warrant (Bounded)
###############################################################################

Perceptual Frame Agreement provides collective *relevance*
only. It does not confer legitimacy, authority, obligation,
or policy justification.
###############################################################################
-/

namespace SigmaR

/--
No implication permitting PFA to escalate beyond
collective relevance (e.g., to legitimacy or authority)
is allowed.
-/
axiom pfa_provides_collective_warrant :
  ¬ (
    ∀ (G : Set Agent) (s : State),
      PFA G s →
      TreatedAsAuthoritative s
  )

end SigmaR
