import SigmaR.StandingAlgebra_FormalCore
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
Prohibiting optimization does not permit inference
between distinct valuation measures.

AntiOptimization does not weaken Independence.
-/
axiom antioptimization_respects_independence :
  ∀ (M₁ M₂ : Agent → State → Nat),
    ¬ (
      ¬ (∃ (O : State → Nat), True) →
      (∀ a s, M₁ a s → M₂ a s)
    )

end SigmaR
