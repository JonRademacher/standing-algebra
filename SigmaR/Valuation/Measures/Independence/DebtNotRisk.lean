import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Measures.StructuralDebt_Definition
import SigmaR.Valuation.Measures.RiskInheritance_Definition

/-!
###############################################################################
# Debt ≠ Risk (Measure Independence)
###############################################################################

Structural debt and risk inheritance are distinct valuation dimensions.

This file prohibits definitional collapse between them.
###############################################################################
-/

namespace SigmaR

/--
Structural debt is not definitionally reducible to risk inheritance.
-/
axiom DebtNotRisk :
  ¬ (∀ (i : Agent) (s : State),
      StructuralDebt i s = RiskInheritance i s)

end SigmaR
