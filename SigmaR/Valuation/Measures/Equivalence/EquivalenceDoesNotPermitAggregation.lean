import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Core.StructuralInterfaces

/-!
###############################################################################
# Equivalence Does Not Permit Aggregation
###############################################################################

Equivalence does not permit aggregation of
valuation measures into a single quantity.
###############################################################################
-/

namespace SigmaR

/--
No implication permitting aggregation of valuation
measures on the basis of equivalence is allowed.
-/
axiom equivalence_not_aggregation :
  ¬ (
    ∃ (M₁ M₂ : Measure) (O : Obj),
      IsMeasure M₁ ∧
      IsMeasure M₂ ∧
      M₁ ≠ M₂ ∧
      EquivalentMeasures M₁ M₂ ∧
      AggregatesFromMeasure O M₁ ∧
      AggregatesFromMeasure O M₂
  )

end SigmaR

