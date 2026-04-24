import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Measures.StandingMeasure_Definition
import SigmaR.Valuation.Measures.CapacityMeasure_Definition

/-!
###############################################################################
# Measure Non-Collapse
###############################################################################

The valuation system is non-degenerate.

This file prevents the trivial model in which all measures
are constant or indistinguishable across all agents and states.
###############################################################################
-/

namespace SigmaR

/--
There exist agents or states that valuation measures distinguish.
-/
axiom MeasuresNonTrivial :
  ∃ (a₁ a₂ : Agent) (s : State),
    StandingMeasure a₁ s ≠ StandingMeasure a₂ s ∨
    CapacityMeasure a₁ s ≠ CapacityMeasure a₂ s

end SigmaR
