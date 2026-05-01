import SigmaR.StandingAlgebra_RegimeStacked

namespace SigmaR

/- =========================================================
   Standing Algebra Σᴿ
   First‑Order Theorem: No Slow Exit Foreclosure
   =========================================================

   Proven version.

   This theorem states that there is no admissible,
   bounded way to gradually eliminate all viable
   exit options.

   It is a direct consequence of the
   Drift + Exit first‑order composition.
   ========================================================= -/

/- -----------------
   No Slow Exit Foreclosure
   ----------------- -/

theorem No_slow_exit_foreclosure :
  ∀ (a : Agent),
    (∃ F : Operation, Exit F ∧ MinStanding ≤ σ (apply F a)) →
    ∀ (D : Operation),
      Drift D →
      ∃ F : Operation,
        Exit F ∧
        MinStanding ≤ σ (apply F (apply D a)) :=
by
  intro a hExit D hDrift
  rcases hExit with ⟨F_exit, hF_exit, hViable⟩
  refine ⟨F_exit, hF_exit, ?_⟩
  exact Exit_preserved_under_drift F_exit D a hF_exit hDrift

end SigmaR
