import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Core.StructuralInterfaces
import SigmaR.Valuation.Measures.Definitions.AutonomyMeasure_Definition
import SigmaR.Valuation.Measures.Definitions.RiskLoad_Definition

/-!
###############################################################################
# Independence: Autonomy Not Risk
###############################################################################

Autonomy measures do not license or imply risk load.
Any relationship between these notions must be introduced
explicitly in higher layers or models.
###############################################################################
-/

namespace SigmaR.Valuation.Measures.Independence

/--
No implication treating autonomy measures as implying
or licensing assumptions of risk load is permitted.
-/
axiom autonomy_not_risk :
  ¬ (
    ∀ (a : Agent) (s : SigmaR.Valuation.State),
      SigmaR.Valuation.Core.TreatedAsRiskFromAutonomyMeasure a s
  )

end SigmaR.Valuation.Measures.Independence
