import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Core.StructuralInterfaces
import SigmaR.Valuation.Measures.AutonomyMeasure_Definition
import SigmaR.Valuation.Measures.RiskLoad_Definition

/-!
###############################################################################
# Independence: Autonomy Not Risk
###############################################################################

Autonomy measures do not license or imply risk load.
Any relationship between these notions must be introduced
explicitly in higher layers or models.
###############################################################################
-/

namespace SigmaR

/--
No implication treating autonomy measures as implying
or licensing assumptions of risk load is permitted.
-/
axiom autonomy_not_risk :
  ¬ (
    ∀ (a : Agent) (s : State),
      TreatedAsRiskFromAutonomyMeasure a s
  )

end SigmaR
