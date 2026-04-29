import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Core.StructuralInterfaces

/-!
###############################################################################
# No Aggregate Optimization
###############################################################################

Distinct valuation dimensions must not be aggregated
into a single optimizing quantity.
###############################################################################
-/

namespace SigmaR

/--
No implication from multiple valuation measures to a
single aggregating optimization objective is permitted.
-/
axiom no_aggregate_optimization :
  ¬ (
    ∃ (O : Obj) (M₁ M₂ : Measure),
      IsMeasure M₁ ∧
      IsMeasure M₂ ∧
      M₁ ≠ M₂ ∧
      Optimizes O ∧
      AggregatesFromMeasure O M₁ ∧
      AggregatesFromMeasure O M₂
  )

end SigmaR
