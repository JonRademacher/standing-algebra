import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Measures.AutonomyMeasure_Definition
import SigmaR.Valuation.Measures.StructuralDebt_Definition

/-!
###############################################################################
# Autonomy ≠ Structural Debt
###############################################################################

Autonomy loss is not equivalent to the accumulation of structural debt.
An agent may lose autonomy without incurring debt,
and may incur debt without immediate autonomy loss.
###############################################################################
-/

namespace SigmaR

axiom AutonomyNotDebt :
  ∀ (a : Agent) (s : State),
    AutonomyMeasure a s ≠ StructuralDebt a

end SigmaR
