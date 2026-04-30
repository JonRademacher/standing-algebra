import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Core.StructuralInterfaces
import SigmaR.Valuation.Measures.ExitViability_Definition
import SigmaR.Valuation.Measures.StandingMeasure_Definition

/-!
###############################################################################
# Independence: Exit Viability Not Standing
###############################################################################

Exit viability does not license or imply standing.

Exit viability concerns the structural ability to refuse or withdraw.
Standing measures recognized status or admissible participation.

No default implication from exit viability to standing
is licensed.
###############################################################################
-/

namespace SigmaR

/--
No implication treating exit viability as constituting
or licensing standing is permitted.
-/
axiom exit_not_standing :
  ¬ (
    ∀ (a : Agent) (s : State),
      TreatedAsStandingFromExitViable a s
  )

end SigmaR
