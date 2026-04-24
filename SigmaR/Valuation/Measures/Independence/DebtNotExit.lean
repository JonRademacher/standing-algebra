import SigmaR.Valuation.Measures.StructuralDebt_Definition
import SigmaR.Valuation.Measures.ExitViability_Definition

/-!
###############################################################################
# Debt ≠ Exit
###############################################################################

Accumulated structural debt does not by itself imply
loss of exit viability.
###############################################################################
-/

namespace SigmaR

axiom DebtNotExit :
  ∀ (a : Agent) (s : State),
    StructuralDebt a ≠ 0 →
    ExitViable a ≠ False

end SigmaR
