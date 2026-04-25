import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Measures.DominationPressure_Definition
import SigmaR.Valuation.Measures.StandingMeasure_Definition

/-!
###############################################################################
# Domination Pressure ≠ Standing
###############################################################################

Domination pressure is a collapse diagnostic.
Standing is a recognition constraint.

They are not definitionally reducible.
###############################################################################
-/

namespace SigmaR

axiom DominationPressureNotStanding :
  ∀ (a : Agent) (s : State),
    DomPressure s ≠ StandingMeasure a s

end SigmaR
