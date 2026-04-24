import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Measures.AutonomyMeasure_Definition
import SigmaR.Valuation.Measures.ExitViability_Definition

/-!
###############################################################################
# Autonomy ≠ Exit Viability
###############################################################################

Autonomy impairment does not by itself constitute exit collapse,
and exit collapse is not reducible to autonomy loss.
###############################################################################
-/

namespace SigmaR

axiom AutonomyNotExit :
  ∀ (a : Agent) (s : State),
    AutonomyMeasure a s ≠ 0 →
    ExitViable a ≠ False

end SigmaR
