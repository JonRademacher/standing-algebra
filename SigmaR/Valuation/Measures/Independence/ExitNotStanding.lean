import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Core.StructuralInterfaces
import SigmaR.Valuation.Measures.Definitions.ExitViability_Definition
import SigmaR.Valuation.Measures.Definitions.StandingMeasure_Definition

open SigmaR.Valuation.Core

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

namespace SigmaR.Valuation.Measures.Independence

/--
No implication treating exit viability as constituting
or licensing standing is permitted.
-/
axiom exit_not_standing :
  ¬ (
    ∀ (a : Agent) (s : State),
      TreatedAsStandingFromExitViable a s
  )

end SigmaR.Valuation.Measures.Independence
