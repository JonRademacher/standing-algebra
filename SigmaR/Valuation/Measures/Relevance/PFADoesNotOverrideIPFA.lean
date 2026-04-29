import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Core.StructuralInterfaces

/-!
###############################################################################
# PFA Does Not Override IPFA
###############################################################################

Collective perceptual agreement does not override
personal informational warrant.
###############################################################################
-/

namespace SigmaR

/--
No implication permitting PFA to cancel or override
agent-specific IPFA is allowed.
-/
axiom pfa_not_override_ipfa :
  ¬ (
    ∀ (G : Set Agent) (a : Agent) (s : State),
      PFA G s →
      IPFA a s →
      ¬ IPFA a s
  )

end SigmaR
