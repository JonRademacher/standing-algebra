import SigmaR.StandingAlgebra_RegimeStacked

namespace SigmaR

/- =========================================================
   Standing Algebra Σᴿ
   First‑Order Theorem: Exit Viability Preservation
   =========================================================

   Proven version.

   This theorem states that viable exit cannot be
   eroded by admissible bounded drift.

   It is a direct consequence of the
   Drift + Exit first‑order composition.
   ========================================================= -/

/- -----------------
   Exit Viability Preservation
   ----------------- -/

theorem Exit_viability_preserved :
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
