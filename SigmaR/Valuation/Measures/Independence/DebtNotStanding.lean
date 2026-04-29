import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Core.StructuralInterfaces
import SigmaR.Valuation.Measures.StructuralDebt_Definition
import SigmaR.Valuation.Measures.StandingMeasure_Definition

/-!
###############################################################################
# Independence: Structural Debt Not Standing
###############################################################################

Structural debt tracks unresolved asymmetry or deferred repair.
Standing measures recognized status or admissible participation.

No default implication from structural debt to loss of standing
is licensed.
###############################################################################
-/

namespace SigmaR

/--
No implication treating structural debt as eliminating,
revoking, or licensing the loss of standing is permitted.
-/
axiom debt_not_standing :
  ¬ (
    ∀ (a : Agent) (s : State),
      TreatedAsStandingRevokedFromStructuralDebt a s
  )

end SigmaR
