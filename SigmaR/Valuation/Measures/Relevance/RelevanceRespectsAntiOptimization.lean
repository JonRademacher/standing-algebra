import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Core.StructuralInterfaces
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
No implication permitting relevance to authorize
objectives, targets, or optimization is allowed.
-/
axiom relevance_respects_antioptimization :
  ¬ (
    ∀ (a : Agent) (s : State) (O : Obj),
      IPFA a s →
      Optimizes O
  )

end SigmaR
