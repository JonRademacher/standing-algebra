import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Measures.StandingMeasure_Definition

/-!
###############################################################################
# Consent ≠ Standing (Measure Independence)
###############################################################################

Consent does not constitute standing and cannot substitute for it.
###############################################################################
-/

namespace SigmaR

/--
Consent is not definitionally reducible to standing.
-/
axiom ConsentNotStanding :
  ¬ (∀ (i : Agent) (s : State),
      Consent i s ↔ StandingMeasure i s > 0)

end SigmaR
