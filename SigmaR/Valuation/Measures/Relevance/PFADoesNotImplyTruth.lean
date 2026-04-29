import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Core.StructuralInterfaces

/-!
###############################################################################
# PFA Does Not Imply Truth
###############################################################################

Perceptual Frame Agreement reflects consistency of honest
perception, not correctness or objective truth.
###############################################################################
-/

namespace SigmaR

/--
No implication from PFA to objective truth or correctness
is permitted.
-/
axiom pfa_not_truth :
  ¬ (
    ∀ (G : Set Agent) (s : State),
      PFA G s →
      TreatedAsTrue s
  )

end SigmaR

