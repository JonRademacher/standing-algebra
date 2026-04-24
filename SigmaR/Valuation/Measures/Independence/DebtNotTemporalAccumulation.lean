import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Measures.TemporalAccumulation_Definition
import SigmaR.Valuation.Measures.StructuralDebt_Definition

/-!
###############################################################################
# Structural Debt ≠ Temporal Accumulation
###############################################################################

Structural debt represents deferred repair.
Temporal accumulation represents irreversible
or narrowing future constraint.

These are distinct valuation dimensions.
###############################################################################
-/

namespace SigmaR

axiom DebtNotTemporalAccumulation :
  ∀ (a : Agent) (s : State),
    StructuralDebt a ≠ TemporalAccumulation a s

end SigmaR
