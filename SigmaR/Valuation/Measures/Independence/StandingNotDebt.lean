import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Core.StructuralInterfaces
import SigmaR.Valuation.Measures.StandingMeasure_Definition
import SigmaR.Valuation.Measures.StructuralDebt_Definition

/-!
###############################################################################
# Independence: Standing Not Structural Debt
###############################################################################

Standing does not license or imply the resolution,
elimination, or absence of structural debt.

Standing measures recognized status or admissible participation.
Structural debt tracks unresolved asymmetry and deferred repair
within a system.

No default implication from standing to structural debt
resolution is licensed.
###############################################################################
-/

namespace SigmaR

/--
No implication treating standing as resolving,
eliminating, or licensing the absence of structural debt
is permitted.
-/
axiom standing_not_debt :
  ¬ (
    ∀ (a : Agent) (s : State),
      TreatedAsStructuralDebtResolvedFromStandingMeasure a s
  )

end SigmaR
