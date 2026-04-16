import SigmaR.StandingAlgebra_FormalCore

namespace SigmaR

/- =========================================================
   Standing Algebra Σᴿ — Successor Regime
   =========================================================

   This regime formalizes non-coercive access to successor
   standing.

   Successor:
   - must be accessible,
   - must not be selectively denied,
   - must be class-uniform,
   - must not privilege agents,
   - must be admissible.

   This file depends ONLY on the Formal Core.
   ========================================================= -/

/- -----------------
   Successor Structure
   ----------------- -/

-- Operations that realize successor standing
axiom SuccessorOp : Operation → Prop

/- -----------------
   Successor Admissibility
   ----------------- -/

-- Successor operations are admissible
axiom Successor_admissible :
  ∀ F : Operation, SuccessorOp F → Admissible F

/- -----------------
   Successor Effect
   ----------------- -/

-- Successor operations increase standing by exactly one
axiom Successor_effect :
  ∀ (F : Operation) (a : Agent),
    SuccessorOp F →
    σ (apply F a) = Nat.succ (σ a)

/- -----------------
   Non-Selective Access
   ----------------- -/

-- Successor access must be class-uniform
axiom Successor_class_uniform :
  ∀ (F₁ F₂ : Operation) (a₁ a₂ : Agent),
    SuccessorOp F₁ →
    SuccessorOp F₂ →
    σ a₁ = σ a₂ →
    cap a₁ = cap a₂ →
    σ (apply F₁ a₁) = σ (apply F₂ a₂)

/- -----------------
   No Coercive Denial
   ----------------- -/

-- Denial of successor access constitutes coercion
axiom Successor_no_denial :
  ∀ a : Agent,
    ∃ F : Operation, SuccessorOp F

/- -----------------
   Non-Privileging
   ----------------- -/

-- Successor does not privilege agents
axiom Successor_non_privileging :
  ∀ (F : Operation) (a₁ a₂ : Agent),
    SuccessorOp F →
    σ a₁ = σ a₂ →
    σ (apply F a₁) = σ (apply F a₂)

end SigmaR
