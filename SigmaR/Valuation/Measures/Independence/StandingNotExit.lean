import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Core.StructuralInterfaces
import SigmaR.Valuation.Measures.Definitions.StandingMeasure_Definition
import SigmaR.Valuation.Measures.Definitions.ExitViability_Definition

open SigmaR.Valuation.Core

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

namespace SigmaR.Valuation.Measures.Independence

/--
No implication treating standing as guaranteeing,
constituting, or licensing exit viability is permitted.
-/
axiom standing_not_exit :
  ¬ (
    ∀ (a : Agent) (s : State),
      TreatedAsExitViableFromStandingMeasure a s
  )

end SigmaR.Valuation.Measures.Independence
