import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Core.StructuralInterfaces
import SigmaR.Valuation.Measures.Definitions.CapacityMeasure_Definition
import SigmaR.Valuation.Measures.Definitions.RiskLoad_Definition

open SigmaR.Valuation.Core

/-!
###############################################################################
# Independence: Capacity Not Risk
###############################################################################

Capacity expresses potential or ability.
Risk load captures exposure to harm or uncertainty.

No default implication from capacity measures to risk
is licensed. Any relationship must be introduced
explicitly in higher layers or models.
###############################################################################
-/

namespace SigmaR.Valuation.Measures.Independence

/--
No implication treating capacity measures as implying
or licensing assumptions of risk load is permitted.
-/
axiom capacity_not_risk :
  ¬ (
    ∀ (a : Agent) (s : State),
      TreatedAsRiskFromCapacityMeasure a s
  )

end SigmaR.Valuation.Measures.Independence
