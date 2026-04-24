import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Measures.MeasureTypingAndScope

/-!
###############################################################################
# Measure Codomain Soundness
###############################################################################

All valuation measures return values in their declared codomain.
No measure escapes Nat or Prop.
###############################################################################
-/

namespace SigmaR

/--
Codomain soundness for valuation measures.
-/
axiom MeasureCodomainSound :
  ∀ (μ : ValuationMeasure) (a : Agent) (s : State),
    μ a s ≥ 0

end SigmaR
