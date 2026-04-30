import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Core.StructuralInterfaces
import SigmaR.Valuation.Measures.StandingMeasure_Definition
import SigmaR.Valuation.Measures.ExitCollapse_Definition

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

namespace SigmaR

/--
No implication treating standing as constituting,
guaranteeing, or licensing exit collapse is permitted.
-/
axiom standing_not_exit_collapse :
  ¬ (
    ∀ (a : Agent) (s : State),
      TreatedAsExitCollapseFromStandingMeasure a s
  )

end SigmaR
