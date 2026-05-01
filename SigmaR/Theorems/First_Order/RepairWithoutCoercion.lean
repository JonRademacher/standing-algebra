import SigmaR.StandingAlgebra_RegimeStacked

namespace SigmaR

/- =========================================================
   Standing Algebra Σᴿ
   First‑Order Theorem: Repair Without Coercion
   =========================================================

   Proven version.

   This theorem states that applying a remedy
   does not itself function as a coercive mechanism:
   it neither reduces standing nor forecloses exit.

   It is a direct consequence of:
   - the Remedy regime (standing preservation), and
   - the Exit + Remedy first‑order composition.
   ========================================================= -/

/- -----------------
   Repair Without Coercion
   ----------------- -/

theorem Repair_without_coercion :
  ∀ (a : Agent) (R : Operation),
    Remedy R →
    (σ (apply R a) ≥ σ a) ∧
    (∃ F : Operation,
       Exit F ∧
       MinStanding ≤ σ (apply F (apply R a))) :=
by
  intro a R hRemedy
  constructor
  · -- Standing is preserved under remedy
    exact Remedy_preserves_standing R a hRemedy
  · -- Exit is preserved under remedy
    -- Use any exit that existed before remedy
    have hExit : ∃ F : Operation, Exit F := by
      -- Exit existence is guaranteed by the Exit regime
      exact Exit_exists
    rcases hExit with ⟨F_exit, hF_exit⟩
    refine ⟨F_exit, hF_exit, ?_⟩
    exact Exit_preserved_under_remedy F_exit R a hF_exit hRemedy

end SigmaR
