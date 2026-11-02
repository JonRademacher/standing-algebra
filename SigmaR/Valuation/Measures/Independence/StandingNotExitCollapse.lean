import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Core.StructuralInterfaces
import SigmaR.Valuation.Measures.Definitions.StandingMeasure_Definition
import SigmaR.Valuation.Measures.Definitions.ExitCollapse_Definition

open SigmaR.Valuation.Core

/-!
###############################################################################
# Independence: Standing Not Exit Collapse
###############################################################################

Standing does not license or imply exit collapse.

Standing measures recognized status or admissible participation.
Exit collapse concerns the loss of viable refusal or withdrawal.

No default implication from standing to exit collapse
is licensed.
###############################################################################
-/

namespace SigmaR.Valuation.Measures.Independence

/--
No implication treating standing as constituting,
guaranteeing, or licensing exit collapse is permitted.
-/
axiom standing_not_exit_collapse :
  ¬ (
    ∀ (a : Agent) (s : State),
      TreatedAsExitCollapseFromStandingMeasure a s
  )

end SigmaR.Valuation.Measures.Independence
