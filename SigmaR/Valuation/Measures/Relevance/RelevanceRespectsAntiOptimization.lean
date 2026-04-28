import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Measures.AntiOptimization.AntiOptimizationContract

/-!
###############################################################################
# Relevance Respects AntiOptimization
###############################################################################

Epistemic relevance must not be interpreted as an
objective, target, or optimization criterion.
###############################################################################
-/

namespace SigmaR

/--
Relevance does not imply optimization.
-/
axiom relevance_respects_antioptimization :
  ¬ (∃ (O : State → Nat),
        True)

end SigmaR
