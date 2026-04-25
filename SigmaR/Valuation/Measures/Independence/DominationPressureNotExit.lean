import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Measures.DominationPressure_Definition
import SigmaR.Valuation.Measures.ExitViability_Definition

/-!
###############################################################################
# Domination Pressure ≠ Exit Viability
###############################################################################

Exit viability is an agent-level structural predicate.
Domination pressure is a global collapse diagnostic.

They must not collapse into one another.
###############################################################################
-/

namespace SigmaR

axiom DominationPressureNotExit :
  ∀ (a : Agent) (s : State),
    DomPressure s ≠ 0 →
    ExitViable a ≠ False

end SigmaR
