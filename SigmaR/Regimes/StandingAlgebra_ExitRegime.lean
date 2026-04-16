import SigmaR.StandingAlgebra_FormalCore

namespace SigmaR

/- =========================================================
   Standing Algebra Σᴿ — Exit Regime
   =========================================================

   This regime formalizes viable, non-coercive exit.

   Exit:
   - must exist,
   - must preserve minimal standing,
   - must not confer advantage,
   - must not be lethal or nullifying.

   This file depends ONLY on the Formal Core.
   ========================================================= -/

/- -----------------
   Exit Structure
   ----------------- -/

-- Exit operations
axiom Exit : Operation → Prop

-- Minimum viable standing (non-lethal threshold)
axiom MinStanding : Nat

/- -----------------
   Exit Existence
   ----------------- -/

-- There exists at least one exit operation
axiom Exit_exists :
  ∃ F : Operation, Exit F

-- Exit operations are admissible
axiom Exit_admissible :
  ∀ F : Operation, Exit F → Admissible F

/- -----------------
   Exit Viability
   ----------------- -/

-- Exit must preserve minimal standing
axiom Exit_preserves_viability :
  ∀ (F : Operation) (a : Agent),
    Exit F →
    MinStanding ≤ σ (apply F a)

-- Exit may reduce standing but not below viability
axiom Exit_no_lethal_drop :
  ∀ (F : Operation) (a : Agent),
    Exit F →
    σ (apply F a) ≤ σ a ∨ σ (apply F a) = σ a

/- -----------------
   Exit Neutrality
   ----------------- -/

-- Exit cannot confer standing advantage
axiom Exit_no_gain :
  ∀ (F : Operation) (a : Agent),
    Exit F →
    σ (apply F a) ≤ σ a

-- Exit preserves equality of standing across agents
axiom Exit_non_privileging :
  ∀ (F : Operation) (a₁ a₂ : Agent),
    Exit F →
    σ a₁ = σ a₂ →
    σ (apply F a₁) = σ (apply F a₂)

/- -----------------
   No Exit Foreclosure
   ----------------- -/

-- Exit availability is not conditional on participation
axiom Exit_not_foreclosed :
  ∀ a : Agent,
    ∃ F : Operation, Exit F ∧ MinStanding ≤ σ (apply F a)

end SigmaR
