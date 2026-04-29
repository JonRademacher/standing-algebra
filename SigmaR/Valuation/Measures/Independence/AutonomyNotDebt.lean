import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Core.StructuralInterfaces
import SigmaR.Valuation.Measures.AutonomyMeasure_Definition
import SigmaR.Valuation.Measures.StructuralDebt_Definition

/-!
###############################################################################
# Independence: Autonomy Not Structural Debt
###############################################################################

Loss of autonomy and accumulation of structural debt are
distinct phenomena. No default implication between them
is licensed at the level of valuation measures.
###############################################################################
-/

namespace SigmaR

/--
No implication treating autonomy measures as implying
or licensing assumptions of structural debt is permitted.
-/
axiom autonomy_not_debt :
  ¬ (
    ∀ (a : Agent) (s : State),
      TreatedAsDebtFromAutonomyMeasure a s
  )

end SigmaR
