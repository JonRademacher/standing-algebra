import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Measures.TemporalAccumulation_Definition
import SigmaR.Valuation.Measures.ExitViability_Definition

/-!
###############################################################################
# Temporal Accumulation ≠ Exit Viability
###############################################################################

Temporal accumulation captures irreversible constraint
over time. Exit viability is a binary structural property.

These must not collapse into one another.
###############################################################################
-/

namespace SigmaR

axiom TemporalAccumulationNotExit :
  ∀ (a : Agent) (s : State),
    TemporalAccumulation a s ≠ 0 →
    ExitViable a ≠ False

end SigmaR
