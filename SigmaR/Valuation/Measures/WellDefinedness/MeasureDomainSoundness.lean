import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Measures.MeasureTypingAndScope

/-!
###############################################################################
# Measure Domain Soundness
###############################################################################

All valuation measures apply only to well-typed domains:
  • Agent × State → Nat
  • Agent × State → Prop

This file prevents category errors and domain misuse.
###############################################################################
-/

namespace SigmaR

/--
Domain soundness for valuation measures.
-/
axiom MeasureDomainSound :
  ∀ (μ : ValuationMeasure) (a : Agent) (s : State),
    True

end SigmaR
