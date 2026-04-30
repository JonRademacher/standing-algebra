import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Core.StructuralInterfaces
import SigmaR.Valuation.Measures.StandingMeasure_Definition
import SigmaR.Valuation.Measures.ExitViability_Definition

/-!
###############################################################################
# Independence: Standing Not Exit Viability
###############################################################################

Standing does not license or imply exit viability.

Standing concerns recognition and admissibility under participation.
Exit viability concerns the structural ability to refuse or withdraw
without coercion.

No default implication from standing to exit viability
is licensed.
###############################################################################
-/

namespace SigmaR

/--
No implication treating standing as guaranteeing,
constituting, or licensing exit viability is permitted.
-/
axiom standing_not_exit :
  ¬ (
    ∀ (a : Agent) (s : State),
      TreatedAsExitViableFromStandingMeasure a s
  )

end SigmaR
