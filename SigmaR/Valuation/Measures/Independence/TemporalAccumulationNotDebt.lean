import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Measures.TemporalAccumulation_Definition
import SigmaR.Valuation.Measures.StructuralDebt_Definition

/-!
###############################################################################
# Temporal Accumulation ≠ Structural Debt
###############################################################################

Temporal accumulation captures time-binding and
irreversibility, not unresolved asymmetry.

Debt may be repaired; temporal harm may persist.
###############################################################################
-/

namespace SigmaR

axiom TemporalAccumulationNotDebt :
  ∀ (a : Agent) (s : State),
    TemporalAccumulation a s ≠ StructuralDebt a

end SigmaR
