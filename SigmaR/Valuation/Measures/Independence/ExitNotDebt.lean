import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Measures.ExitCollapse_Definition
import SigmaR.Valuation.Measures.StructuralDebt_Definition

/-!
###############################################################################
# Exit ≠ Debt (Measure Independence)
###############################################################################

Exit collapse is a structural boundary condition,
not an accumulation of debt.
###############################################################################
-/

namespace SigmaR

/--
Exit collapse is not definitionally reducible to structural debt.
-/
axiom ExitNotDebt :
  ¬ (∀ (i : Agent) (s : State),
      ExitCollapse i s ↔ StructuralDebt i s = 0)

end SigmaR
