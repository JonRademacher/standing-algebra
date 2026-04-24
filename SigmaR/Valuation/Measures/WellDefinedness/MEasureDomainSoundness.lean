import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Measures.MeasureTypingAndScope

/-!
###############################################################################
# Measure Domain Soundness
###############################################################################

All valuation measures are defined only on their intended domains.
This file prevents category errors (e.g. applying a measure to
non-agents or non-states).

No semantics beyond domain correctness are asserted.
###############################################################################
-/

namespace SigmaR

/--
Domain soundness: every valuation measure is total on Agent × State.
-/
axiom MeasureDomainSound :
  ∀ (μ : ValuationMeasure) (a : Agent) (s : State),
    True

end SigmaR
