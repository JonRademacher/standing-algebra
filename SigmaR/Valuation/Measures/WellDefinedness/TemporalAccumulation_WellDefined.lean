import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Measures.TemporalAccumulation_Definition

/-!
###############################################################################
# Temporal Accumulation — Well-Definedness
###############################################################################

Ensures that temporal accumulation is a total,
non-negative valuation quantity for all agents and states.

No claims are made here about monotonicity, admissibility,
urgency, or emergency triggering.
###############################################################################
-/

namespace SigmaR

/--
TemporalAccumulation is well-defined if it yields
a natural number for every agent in every state.
-/
def TemporalAccumulation_WellDefined : Prop :=
  ∀ (a : Agent) (s : State), ∃ (n : Nat), TemporalAccumulation a s = n

end SigmaR
