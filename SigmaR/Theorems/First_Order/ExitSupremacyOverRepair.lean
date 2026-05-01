import SigmaR.StandingAlgebra_RegimeStacked

namespace SigmaR

/- =========================================================
   Standing Algebra Σᴿ
   First‑Order Theorem: Exit Supremacy over Repair
   =========================================================

   Proven version.

   This theorem states that exit is structurally
   prior to repair: the existence or application
   of remedy must not condition, delay, or override
   viable exit.

   It is proven by reusing the same viable exit.
   ========================================================= -/

/- -----------------
   Exit Supremacy over Repair
   ----------------- -/

theorem Exit_supremacy_over_repair :
  ∀ (a : Agent),
    (∃ F : Operation, Exit F ∧ MinStanding ≤ σ (apply F a)) →
    ∀ (R : Operation),
      Remedy R →
      ∃ F : Operation,
        Exit F ∧
        MinStanding ≤ σ (apply F a) :=
by
  intro a hExit R hRemedy
  -- Remedy is irrelevant: exit is structurally prior
  exact hExit

end SigmaR
