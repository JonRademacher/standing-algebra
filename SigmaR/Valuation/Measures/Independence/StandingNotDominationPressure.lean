import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Core.StructuralInterfaces
import SigmaR.Valuation.Measures.StandingMeasure_Definition
import SigmaR.Valuation.Measures.DominationPressure_Definition

/-!
###############################################################################
# Independence: Standing Not Domination Pressure
###############################################################################

Standing does not license or imply domination pressure.

Standing measures recognized status or admissible participation.
Domination pressure is a system-level diagnostic indicating
structural instability or approach to collapse.

No default implication from standing to domination pressure
is licensed.
###############################################################################
-/

namespace SigmaR

/--
No implication treating standing as preventing,
resolving, or licensing the absence of domination pressure
is permitted.
-/
axiom standing_not_domination_pressure :
  ¬ (
    ∀ (a : Agent) (s : State),
      TreatedAsDominationPressureFromStandingMeasure a s
  )

end SigmaR
