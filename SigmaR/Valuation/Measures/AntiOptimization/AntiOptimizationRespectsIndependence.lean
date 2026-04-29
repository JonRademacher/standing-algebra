import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Core.StructuralInterfaces
import SigmaR.Valuation.Measures.Independence.IndependenceContract
import SigmaR.Valuation.Measures.AntiOptimization.AntiOptimizationContract

/-!
###############################################################################
# AntiOptimization Respects Independence
###############################################################################

This file establishes the boundary between the AntiOptimization
and Independence layers.

AntiOptimization prohibits teleological and instrumental reasoning.
It does NOT license new inferences between valuation measures.

All inferential restrictions imposed by the Independence layer
remain fully in force.
###############################################################################
-/

namespace SigmaR

/--
No implication from anti-optimization to weakened independence
between valuation measures is permitted.
-/
axiom antioptimization_respects_independence :
  ¬ (
    ¬ (∃ (O : Obj), Optimizes O) →
    ∃ (M₁ M₂ : Measure),
      ¬ IndependentMeasures M₁ M₂
  )

end SigmaR
