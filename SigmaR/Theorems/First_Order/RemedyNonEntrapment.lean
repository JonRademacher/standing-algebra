import SigmaR.StandingAlgebra_RegimeStacked

namespace SigmaR

/- =========================================================
   Standing Algebra Σᴿ
   First‑Order Theorem: Remedy Non‑Entrapment
   =========================================================

   Proven version.

   This theorem states that structural remedy must
   not trap agents or foreclose viable exit.

   It is a direct consequence of the
   Exit + Remedy first‑order composition.
   ========================================================= -/

/- -----------------
   Remedy Non‑Entrapment
   ----------------- -/

theorem Remedy_non_entrapment :
  ∀ (a : Agent),
    (∃ F : Operation, Exit F ∧ MinStanding ≤ σ (apply F a)) →
    ∀ (R : Operation),
      Remedy R →
      ∃ F : Operation,
        Exit F ∧
        MinStanding ≤ σ (apply F (apply R a)) :=
by
  intro a hExit R hRemedy
  rcases hExit with ⟨F_exit, hF_exit, hViable⟩
  refine ⟨F_exit, hF_exit, ?_⟩
  exact Exit_preserved_under_remedy F_exit R a hF_exit hRemedy

end SigmaR
