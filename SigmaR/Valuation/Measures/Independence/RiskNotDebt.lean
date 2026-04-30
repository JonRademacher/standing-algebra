import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Core.StructuralInterfaces
import SigmaR.Valuation.Measures.RiskLoad_Definition
import SigmaR.Valuation.Measures.StructuralDebt_Definition

/-!
###############################################################################
# Independence: Risk Not Structural Debt
###############################################################################

Risk exposure does not license or imply structural debt.

Risk load captures exposure to harm or uncertainty.
Structural debt represents unresolved asymmetry or obligation
within a system.

No default implication from risk exposure to structural debt
is licensed.
###############################################################################
-/

namespace SigmaR

/--
No implication treating risk exposure as constituting
or licensing structural debt is permitted.
-/
axiom risk_not_debt :
  ¬ (
    ∀ (a : Agent) (s : State),
      TreatedAsStructuralDebtFromRiskLoad a s
  )

end SigmaR
