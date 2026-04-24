import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Measures.AutonomyMeasure_Definition
import SigmaR.Valuation.Measures.StructuralDebt_Definition

/-!
###############################################################################
# Structural Debt ≠ Autonomy
###############################################################################
-/

namespace SigmaR

axiom DebtNotAutonomy :
  ∀ (a : Agent) (s : State),
    StructuralDebt a ≠ AutonomyMeasure a s

end SigmaR
