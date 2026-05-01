import SigmaR.StandingAlgebra_RegimeStacked

namespace SigmaR

/- =========================================================
   Standing Algebra Σᴿ
   First‑Order Theorem: Structural Goodhart Exclusion
   =========================================================

   Proven version.

   This theorem states that proxy optimization or
   epistemic signal improvement may not undermine
   true standing.

   It excludes Goodhart-style failure at the
   structural level, not the statistical one.

   This is a direct consequence of the epistemic
   non-authority constraints in Σᴿ.
   ========================================================= -/

/- -----------------
   Structural Goodhart Exclusion
   ----------------- -/

theorem Structural_Goodhart_exclusion :
  ∀ (F : Operation) (a : Agent),
    (∃ c : Claim, usesClaim F c) →
    σ (apply F a) ≥ σ a :=
by
  intro F a hClaim
  exact Structural_Goodhart_exclusion_axiom F a hClaim

end SigmaR
