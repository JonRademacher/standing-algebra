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

-- Operations that participate in the Successor Regime.
-- This is the regime-level carrier of the successor constraints: the
-- justification modules constrain `SuccessorRegimeOp`, the umbrella module
-- `SigmaR/Justifications/Regime_Legitimacy/SuccessorRegime/SuccessorRegime_Justification.lean`
-- aggregates them and relates it to successor consistency.
axiom SuccessorRegimeOp : Operation → Prop

-- Predicate: operation `F` is successor-consistent with respect to standing.
-- Declared at the regime level so that the successor justification and the
-- operations layer can both refer to it without importing each other.
axiom SuccessorConsistent : Operation → Prop

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
