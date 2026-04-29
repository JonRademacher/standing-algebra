import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Core.StructuralInterfaces

/-!
###############################################################################
# Plurality Does Not Require PFA
###############################################################################

Plurality exists independently of perceptual agreement.

Perceptual Frame Agreement may express or stabilize plurality,
but it does not generate it.
###############################################################################
-/

namespace SigmaR

/--
No implication treating PFA as a necessary condition
for plurality is permitted.
-/
axiom plurality_does_not_require_pfa :
  ¬ (
    ∀ (G : Set Agent) (s : State),
      TreatedAsPlurality s →
      PFA G s
  )

end SigmaR

