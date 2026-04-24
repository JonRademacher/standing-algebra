import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Measures.AutonomyMeasure_Definition
import SigmaR.Valuation.Measures.StandingMeasure_Definition

/-!
###############################################################################
# Autonomy ≠ Standing
###############################################################################

Autonomy is not reducible to standing.
Standing may be preserved while autonomy is impaired.
###############################################################################
-/

namespace SigmaR

axiom AutonomyNotStanding :
  ∀ (a : Agent) (s : State),
    AutonomyMeasure a s ≠ StandingMeasure a s

end SigmaR
