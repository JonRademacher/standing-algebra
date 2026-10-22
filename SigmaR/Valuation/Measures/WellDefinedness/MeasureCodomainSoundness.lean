import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Measures.Definitions.MeasureTypingAndScope

/-!
###############################################################################
# Measure Codomain Soundness
###############################################################################

All valuation measures return values in their declared codomain.
No measure escapes Nat or Prop.
###############################################################################
-/

namespace SigmaR.Valuation.Measures.WellDefinedness

/--
Codomain soundness for valuation measures.
-/
axiom MeasureCodomainSound :
  ∀ (μ : SigmaR.Valuation.Measures.Definitions.ValuationMeasure)
    (a : SigmaR.Agent) (s : SigmaR.Valuation.State),
    μ a s ≥ 0

end SigmaR.Valuation.Measures.WellDefinedness
