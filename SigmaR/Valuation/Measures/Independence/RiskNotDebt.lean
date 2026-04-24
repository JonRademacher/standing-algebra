import SigmaR.Valuation.Measures.RiskLoad_Definition
import SigmaR.Valuation.Measures.StructuralDebt_Definition

/-!
###############################################################################
# Risk ≠ Debt
###############################################################################

Risk exposure does not constitute structural debt.
Debt represents unresolved asymmetry, not mere exposure.
###############################################################################
-/

namespace SigmaR

axiom RiskNotDebt :
  ∀ (a : Agent) (s : State),
    RiskLoad a s ≠ StructuralDebt a

end SigmaR
