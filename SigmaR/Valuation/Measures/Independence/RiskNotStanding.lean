import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Measures.RiskInheritance_Definition
import SigmaR.Valuation.Measures.StandingMeasure_Definition

/-!
###############################################################################
# Risk ≠ Standing (Measure Independence)
###############################################################################

Risk inheritance does not constitute standing
and cannot substitute for it.
###############################################################################
-/

namespace SigmaR

/--
Risk inheritance is not definitionally reducible to standing.
-/
axiom RiskNotStanding :
  ¬ (∀ (i : Agent) (s : State),
      RiskInheritance i s = StandingMeasure i s)

end SigmaR
